class CommentsSerializer < ActiveModel::Serializer
  attributes :body, :published_at
  belongs_to :post
end
