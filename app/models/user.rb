require 'securerandom'
class User < ApplicationRecord
  before_create :set_token
  has_many :posts
  has_many :comments

  validates :nickname, :email, :password, presence: true

  private

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.delete(/\-/,'')
  end
end
