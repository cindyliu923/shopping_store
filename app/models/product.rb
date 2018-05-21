class Product < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :price

  has_many :crat_items, dependent: :destroy
  has_many :cart, through: :crat_items
end
