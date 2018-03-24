class Member < ApplicationRecord
  require 'date'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
 validates :name,  presence: true, length: { maximum: 30 }
 validates :birth, presence: true
 # validate :date_valid?
 has_many :gmaps
 mount_uploader :image, ImageUploader

 private
 # def date_valid?
 #   errors.add(:birth,'正しい生年月日ではありません')
 #     unless
 #         birth_tmp = birth
 #         birth = birth_tmp if birth.tr!("０-９","0-9") == nil
 #     if /(\d{4})年(\d{1,2})月(\d{1,2})日/ =~ birth
 #         birth =[$1,$2,$3].join("/")
 #     end
 #       birth = birth.to_s
 #       !! Date.parse(birth) rescue false
 #     end
 # end
end
