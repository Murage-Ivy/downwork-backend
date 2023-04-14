class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :post_id
end
