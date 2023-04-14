class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :image_url, presence: true
  validates :image_url, format: { with: URI::regexp(%w(http https)) }
end
