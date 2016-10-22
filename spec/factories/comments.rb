FactoryGirl.define do
  factory :comment do
    body "MyString"
    author "MyString"
    published_at Faker::Date.between(2.days.ago, Date.today)
  end
end
