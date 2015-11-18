class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]
  
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
      if index
        prev_id = query[index-1] unless index.zero?
        self.class.find_by_id(prev_id)
      end
    end
  end

  def next(query)
    unless query.nil?
      index = query.find_index(self.id)
      if index
        next_id = query[index+1] unless index == query.size
        self.class.find_by_id(next_id)
      end
    end
  end

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :name
    ]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

end
