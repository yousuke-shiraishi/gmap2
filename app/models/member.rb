class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
 validates :name,  presence: true, length: { maximum: 30 }
 validates :birth, presence: true
 has_many :gmaps
 mount_uploader :image, ImageUploader

end
