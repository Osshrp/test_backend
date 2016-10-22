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

  private

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
