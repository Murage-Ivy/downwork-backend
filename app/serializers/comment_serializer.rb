class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id
  belongs_to :user
end
