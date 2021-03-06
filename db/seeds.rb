# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Dan Waldkirch",
             email: "dan@example.com",
             password:              "crucial",
             password_confirmation: "crucial",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
10.times do
  title = Faker::Lorem.sentence(1)
  artist = Faker::Lorem.sentence(1)
  genre = Faker::Lorem.sentence(1)
  lyrics = Faker::Lorem.sentence(5)
  users.each { |user| user.submissions.create!(title: title, artist: artist, genre: genre, lyrics: lyrics) }
end