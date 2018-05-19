class Gmap < ApplicationRecord
  require 'digest/md5'
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates :coment, presence: true, length: { minimum: 1, maximum: 255 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :image, presence: true

  before_save :encrypt_magic_word

  def encrypt_magic_word
    if magic_word.present?
      self.magic_word = Digest::MD5.hexdigest(self.magic_word)
    end
  end

  belongs_to :member
  mount_uploader :image, ImageUploader
end
