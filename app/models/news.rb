class News < ActiveRecord::Base
  # image
  attr_accessor :delete_image
  has_attached_file :image
  before_validation { self.image = nil if self.delete_image == '1' }
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

  #scope
  default_scope -> { order('news_date DESC') }
  
end
