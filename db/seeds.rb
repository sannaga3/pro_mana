# 40.times do |i|
#   User.create!(
#     email: "#{i}@example.com",
#     name: "ユーザー#{i}",
#     password: "aaaaaa",
#     admin: false
#   )
# end

# 40.times do |n|
#   Food.create!(
#     name: "卵豆腐#{n}",
#     protein: rand(1..10) ,
#     quantity: 1,
#     unit: "個",
#     user_id: User.first.id + n
#   )
# end

# 5.times do |m|
#   Record.create!(
#     ate: 1,
#     record_on: "2021-06-09",
#     food_id: Record.first.id + m,
#     user_id: User.first.id + m
#   )
# end

40.times do |l|
  Friendship.create!(
    follower_id: User.first.id,
    followed_id: User.second.id + 2 + l,
  )
end