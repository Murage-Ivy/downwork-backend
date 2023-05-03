class Post < ApplicationRecord
  belongs_to :user
#   has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :description, presence: true
  validates :description, length: { minimum: 10 }
  validates :image_url, presence: true
  validates :image_url, format: { with: URI::regexp(%w(http https)) }
  validates :likes, presence: true
  validates :likes, numericality: { only_integer: true }
  validates :likes, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }
  validates :user_id, numericality: { greater_than: 0 }
end
