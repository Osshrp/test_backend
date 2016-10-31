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
    users = []
    User.all.each do |user|
      user_hash = {}
      user_hash = {
        nickname: user.nickname,
        email: user.email,
        posts: user.posts.where("published_at between ? and ?",
         params[:start_date].to_date, params[:end_date].to_date).count,
        comments: user.comments.where("published_at between ? and ?",
         params[:start_date], params[:end_date]).count
      }
      users << user_hash
    end
    users.sort_by { |user| user[:quantity] = -(user[:posts]+user[:comments]).to_f/10 }
  end

  private

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
