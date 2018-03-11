class Product < ApplicationRecord
  mount_uploader :image, PhotoUploader

end
