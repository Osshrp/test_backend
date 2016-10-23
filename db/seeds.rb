# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  george = User.where(
    nickname: Faker::Internet.user_name,
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(5)
  ).create
  bob = User.where(
    nickname: Faker::Internet.user_name,
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(5)
  ).create

  20.times do
    post = george.posts.create(
      title: [Faker::Hacker.adjective, Faker::Hacker.noun].join(' ').titleize,
      body: Faker::Hacker.say_something_smart,
      author: george.nickname,
      user_id: george.id,
      published_at: Faker::Date.between(1.month.ago, Date.today)
    )
    post.comments.create(
      body: Faker::Hipster.sentence,
      author: bob.nickname,
      user_id: bob.id,
      published_at: Faker::Date.between(1.month.ago, Date.today)
    )
  end
end
