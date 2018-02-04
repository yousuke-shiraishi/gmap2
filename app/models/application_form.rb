class ApplicationForm
  include ActiveModel::Model
  include UsersHelper
  attr_accessor :name
  attr_accessor :birth
  attr_accessor :email
  attr_accessor :magic_word
  validates :magic_word,presence:false
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  before_save { email.downcase! }
  validates :birth, presence: true,birth_format: true
end
