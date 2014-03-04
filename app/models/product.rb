class Product < ActiveRecord::Base
  belongs_to :category
  paginates_per 24

  # image
  attr_accessor :delete_image
  has_attached_file :image
  before_validation { self.image = nil if self.delete_image == '1' }
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

  # validates
  validates_presence_of :sequence, :name, :category

  #scope
  default_scope -> { where("sequence >= 0").order('sequence ASC, id DESC') }

  # threading comments
  acts_as_commentable

  # NEXT / PREVIOUS FUNCTIONALITY
  def previous(query)
    unless query.nil?
      index = query.find_index(self.id)
      prev_id = query[index-1] unless index.zero?
      self.class.find_by_id(prev_id)
    end
  end

  def next(query)
    unless query.nil?
      index = query.find_index(self.id)
      next_id = query[index+1] unless index == query.size
      self.class.find_by_id(next_id)
    end
  end
end
