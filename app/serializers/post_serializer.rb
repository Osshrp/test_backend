class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :published_at
  has_many :comments
end
