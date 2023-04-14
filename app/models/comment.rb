class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :content, presence: true
    validates :content, length: { minimum: 3 }
    validates :user_id, presence: true
    validates :user_id, numericality: { only_integer: true }
    validates :user_id, numericality: { greater_than: 0 }
    validates :post_id, presence: true
    validates :post_id, numericality: { only_integer: true }
    validates :post_id, numericality: { greater_than: 0 }
end
