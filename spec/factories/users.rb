FactoryGirl.define do
  factory :user do
    # sequence(:nickname) { |n| "Nick#{n}" }
    nickname "Nick"
    sequence(:email) { |n| "test#{n}@example.com" }
    # email "test@example.com"
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

    factory :user_with_5_posts_10_comments do
      transient do
        posts_count 5
        # comments_count 10
      end

      after(:create) do |user, evaluator|
        # create_list(:post, evaluator.posts_count, user: user)
        create_list(:comment, 10, user: user)
        # create_list(:post, 5, user: user)
      end
    end
  end

  # factory :user_with_5_posts_10_comments do
  #   sequence(:nickname) { |n| "Nick#{n}" }
  #   sequence(:email) { |n| "user#{n}@example.com" }
  #   password "123456"
  #   token "12345"

  #   transient do
  #     posts_count 5
  #     comments_count 10
  #   end

  #   after(:create) do |user, evaluator|
  #     create_list(:post, evaluator.posts_count, user: user)
  #     create_list(:comment, evaluator.comments_count, user: user)
  #   end
  # end

  # factory :users_with_10_posts_15_comments do
  #   sequence(:nickname) { |n| "Bob#{n}" }
  #   sequence(:email) { |n| "user#{n}@example.com" }
  #   password "123456"
  #   token "12345"

  #   transient do
  #     posts_count 10
  #     comments_count 15
  #   end

  #   after(:create) do |user, evaluator|
  #     create_list(:post, evaluator.posts_count, user: user)
  #     create_list(:comment, evaluator.comments_count, user: user)
  #   end
  # end

  # factory :users_with_2_posts_35_comments do
  #   sequence(:nickname) { |n| "Bill#{n}" }
  #   sequence(:email) { |n| "user#{n}@example.com" }
  #   password "123456"
  #   token "12345"

  #   transient do
  #     posts_count 2
  #     comments_count 35
  #   end

  #   after(:create) do |user, evaluator|
  #     create_list(:post, evaluator.posts_count, user: user)
  #     create_list(:comment, evaluator.comments_count, user: user)
  #   end
  # end
end
