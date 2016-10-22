FactoryGirl.define do
  factory :post do
    sequence(:title, 1000) { |n| "Title#{n}" }
    sequence(:body, 1000) { |n| "Body#{n}" }
    author "Author"
    published_at Faker::Date.between(3.days.ago, Date.today)

    factory :post_with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end
  end
end
