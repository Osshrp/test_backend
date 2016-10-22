FactoryGirl.define do
  factory :user do
    nickname "Nick"
    # sequence(:email) { |n| "test#{n}@example.com" }
    email "test@example.com"
    password "123456"
    token "12345"

    factory :user_with_posts do
      transient do
        posts_count 10
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
