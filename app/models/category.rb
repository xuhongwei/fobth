class Category < ActiveRecord::Base
  validates_presence_of :name, :sequence
  has_many :products
  def to_param
    name
  end
end
