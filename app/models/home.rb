class Home < ActiveRecord::Base
  # image
  attr_accessor :delete_image
  has_attached_file :image
  before_validation { self.image = nil if self.delete_image == '1' }
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

  #photo
  attr_accessor :delete_photo
  has_attached_file :photo
  before_validation { self.photo = nil if self.delete_photo == '1' }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
end
