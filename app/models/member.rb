class Member < ApplicationRecord
  attr_accessor :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :name,  presence: true, length: { maximum: 30 }
  validates :birth, presence: true
  has_many :gmaps
  mount_uploader :image, ImageUploader
end
