class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :image_url
end
