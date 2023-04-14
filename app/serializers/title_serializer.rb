class TitleSerializer < ActiveModel::Serializer
  attributes :id, :description, :user_id, :likes, :image_url
end
