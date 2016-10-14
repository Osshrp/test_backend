# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
george = User.where(
  nickname: Faker::Internet.user_name,
  email: Faker::Internet.free_email
).create
bob    = User.where(
  nickname: Faker::Internet.user_name,
  email: Faker::Internet.free_email
).create

2.times do
  post = george.posts.create(
    title: [Faker::Hacker.adjective, Faker::Hacker.noun].join(' ').titleize,
    body: Faker::Hacker.say_something_smart,
    author: george.nickname,
    published_at: Faker::Date.between(3.days.ago, Date.today)
  )
  # byebug
  post.comments.create(
    body: Faker::Hipster.sentence,
    author: bob.nickname,
    published_at: Faker::Date.between(2.days.ago, Date.today)
  )
end
