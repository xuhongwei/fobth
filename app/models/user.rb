class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2, :facebook, :twitter]

  private 
    def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        registered_user.remember_me!
        return registered_user
      else
        user = User.create(
          email: auth.info.email, password: Devise.friendly_token[0,20], password_confirmation: Devise.friendly_token[0,20]
        )

        if user.save
          user.remember_me!
          return user
        end
      end
    end
end