class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  validates_presence_of :name, :sequence
  has_many :products

  # def to_param
  #   name
  # end

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
