class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true

  def self.set_published_at(post)
    post.published_at = DateTime.now
    @post = post
  end
end
