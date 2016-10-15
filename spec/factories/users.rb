FactoryGirl.define do
  factory :user do
    nickname "Nick"
    # sequence(:email) { |n| "test#{n}@example.com" }
    email "test@example.com"
    password "123456"
  end
end
