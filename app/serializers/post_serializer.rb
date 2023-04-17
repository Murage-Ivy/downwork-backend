class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id, :likes, :image_url
  has_many :comments
end
