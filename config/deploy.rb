require 'mina/bundler' 
require 'mina/rails' 
require 'mina/git'
require 'mina/rvm'

set :rails_env, 'production'
set :domain, '106.187.41.16' 
set :deploy_to, '/home/rails/fobth.com' 
set :repository, 'https://github.com/xuhongwei/fobth.git'
set :branch, 'master'

set :shared_paths, ['config/database.yml', 'log', 'public/system','public/ckeditor_assets']
# setting the term_mode to system disable the "pretty-print" but prevent some other issues
set :term_mode, :system

# Optional SSH settings:
# SSH forward agent to ensure that credentials are passed through for git operations
set :forward_agent, true

set :user, 'rails'
set :ssh_options, '-A'

task :environment do
  invoke :'rvm:use[ruby-2.0.0-p451@default]'
end

# Function extracted from http://blog.nicolai86.eu/posts/2013-05-06/syncing-database-content-down-with-mina
# allowing to read the content of the database.yml file
RYAML = <<-BASH
function ryaml {
  ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' "$@"
};
BASH

# Execute all setup tasks defined below
desc "Create new folder structure + database.yml + DB + VirtualHost"
task :'setup:all' => :environment do
  queue! %[echo "-----> Setup folder structure on server"]
  invoke :setup
  queue! %[echo "-----> Setup the DB (create user / DB)"]
  invoke :'setup:db'
  queue! %[echo "-----> Deploy Master for this version"]
  invoke :deploy
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Fill in information below to populate 'shared/config/database.yml'."]
  invoke :'setup:db:database_yml'
end

# Populate file database.yml with the appropriate rails_env
# Database name and user name are based on convention
# Password is defined by the user during setup
desc "Populate database.yml"
task :'setup:db:database_yml' => :environment do
  puts "Enter a name for the new database"
  db_name = STDIN.gets.chomp
  puts "Enter a user for the new database"
  db_username = STDIN.gets.chomp
  puts "Enter a password for the new database"
  db_pass = STDIN.gets.chomp
  # Virtual Host configuration file
  database_yml = <<-DATABASE.dedent
    #{rails_env}:
      adapter: mysql2
      encoding: utf8
      database: #{db_name}
      username: #{db_username}
      password: #{db_pass}
      host: localhost
      timeout: 5000
  DATABASE
  queue! %{
    echo "-----> Populating database.yml"
    echo "#{database_yml}" > #{deploy_to!}/shared/config/database.yml
    echo "-----> Done"
  }
end

# Create the new database based on information from database.yml
# In this application DB, user is given full access to the new DB
desc "Create new database"
task :'setup:db' => :environment do
  queue! %{
    echo "-----> Import RYAML function"
    #{RYAML}
    echo "-----> Read database.yml"
    USERNAME=$(ryaml #{deploy_to!}/#{shared_path!}/config/database.yml #{rails_env} username)
    PASSWORD=$(ryaml #{deploy_to!}/#{shared_path!}/config/database.yml #{rails_env} password)
    DATABASE=$(ryaml #{deploy_to!}/#{shared_path!}/config/database.yml #{rails_env} database)
    echo "-----> Create SQL query"
    Q1="CREATE DATABASE IF NOT EXISTS $DATABASE;"
    Q2="GRANT USAGE ON *.* TO $USERNAME@localhost IDENTIFIED BY '$PASSWORD';"
    Q3="GRANT ALL PRIVILEGES ON $DATABASE.* TO $USERNAME@localhost;"
    Q4="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}${Q4}"
    echo "-----> Execute SQL query to create DB and user"
    echo "-----> Enter MySQL root password on prompt below"
    #{echo_cmd %[mysql -uroot -p -e "$SQL"]}
    echo "-----> Done"
  }
end

desc "Deploys the current version to the server."
task :deploy => :environment do 
  deploy do 
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install' 

    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile' 
    
    to :launch do 
      queue 'sudo killall -HUP nginx'
    end 
  end 
end

task :console => :environment do
  queue "cd #{deploy_to}/current && bundle exec rails c production"
end

#########################################################################
#
# Libraries
#
##########################################################################

#
# See https://github.com/cespare/ruby-dedent/blob/master/lib/dedent.rb
#
class String
  def dedent
    lines = split "\n"
    return self if lines.empty?
    indents = lines.map do |line|
      line =~ /\S/ ? (line.start_with?(" ") ? line.match(/^ +/).offset(0)[1] : 0) : nil
    end
    min_indent = indents.compact.min
    return self if min_indent.zero?
    lines.map { |line| line =~ /\S/ ? line.gsub(/^ {#{min_indent}}/, "") : line }.join "\n"
  end
end