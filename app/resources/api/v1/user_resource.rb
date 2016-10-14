module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :nickname

      has_many :posts
      has_many :comments
    end
  end
end
