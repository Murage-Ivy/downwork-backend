class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
  validates :post_id, uniqueness: { scope: :user_id }

  def self.like_post(user_id, post_id)
    Like.create(user_id: user_id, post_id: post_id)
  end

  def self.unlike_post(user_id, post_id)
    Like.find_by(user_id: user_id, post_id: post_id).destroy
  end
end
