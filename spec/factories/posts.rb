FactoryGirl.define do
  factory :post do
    sequence(:title, 1000) { |n| "Title#{n}" }
    sequence(:body, 1000) { |n| "Body#{n}" }
    author "Author"
  end
end
