require 'securerandom'
class User < ApplicationRecord
  before_create :set_token
  has_many :posts
  has_many :comments

  validates :nickname, :email, :password, presence: true
  validates :avatar, file_size: { less_than_or_equal_to: 3.megabytes },
              file_content_type: { allow: ['image/jpeg',
                                           'image/jpg',
                                           'image/png'] }
  mount_uploader :avatar, AvatarUploader

  def self.select_users(params)
    users_arr = []
    users = User.left_joins(:posts, :comments).
      select("users.nickname, users.email,
              count(posts.id) as posts_count,
              count(comments.id) as comments_count").
      where("posts.published_at between ? and ?
             or comments.published_at between ? and ?",
        params[:start_date].to_date, params[:end_date].to_date,
        params[:start_date].to_date, params[:end_date].to_date).
      group('users.nickname, users.email')
    users.each do |user|
      user_hash = {}
      user_hash = {
        nickname: user.nickname,
        email: user.email,
        posts: user.posts_count,
        comments: user.comments_count
      }
      users_arr << user_hash
    end
    users_arr.sort_by { |user| user[:quantity] = -(user[:posts]+user[:comments]).to_f/10 }
  end

  private

  def set_token
    return if token.present?
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
