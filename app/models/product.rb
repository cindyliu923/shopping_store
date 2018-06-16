class Product < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :price

  has_many :cart_items, dependent: :restrict_with_error
  has_many :cart, through: :cart_items
end
