# require 'rails_helper'

module Helpers
  def select_users users_names
    users = []
    users << FactoryGirl.create(:user, nickname: "Bill")
    users << FactoryGirl.create(:user, nickname: "Jhon")
    users << FactoryGirl.create(:user, nickname: "Linda")

    FactoryGirl.create_list(:post, 5, user: users[0])
    FactoryGirl.create_list(:comment, 50, user: users[1])
    FactoryGirl.create_list(:post, 14, user: users[2])

    expected_array = []
    users.each do |user|
      user_hash = {}
        user_hash = {
          nickname: user.nickname,
          email: user.email,
          posts: user.posts.count,
          comments: user.comments.count
        }
      expected_array << user_hash
    end
    expected_array.sort_by! do |user|
      user[:quantity] = -(user[:posts]+user[:comments]).to_f/10
    end

    expected_array
  end
end