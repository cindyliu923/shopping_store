class Product < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :price

end
