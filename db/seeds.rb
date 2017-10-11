# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# DIVE09 のテキストの中で書いてあったコード
# 100.times do |n|
#   email = Faker::Internet.email
#   password = "1qAZ2wSX"
#   User.create!(email: email,
#               password: password,
#               password_confirmation: password,
#               name: "abc"
#               )
# end

n = 1
10.times do |n|
  email = Faker::Internet.email
  password = "1qAZ2wSX"
  User.create!(
              uid: 100 + n,
              email: email,
              password: password,
              password_confirmation: password,
              name: n,
              provider: n
              )
  n = n + 1
end

# n = 1
# while n <= 100
#   Blog.create(
#     title: "a" + n.to_s,
#     content: "b" + n.to_s,
#     user_id: n,
#     user_name: "c" + n.to_s
#   )
#   n = n + 1
# end
