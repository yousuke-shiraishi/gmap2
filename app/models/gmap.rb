class Gmap < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates :coment, presence: true, length: { minimum: 1, maximum: 255 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :image, presence: true

  belongs_to :member
  mount_uploader :image, ImageUploader
end
