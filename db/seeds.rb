# 40.times do |i|
#   User.create!(
#     email: "#{i}@example.com",
#     name: "ユーザー#{i}",
#     password: "aaaaaa",
#     admin: false
#   )
# end

40.times do |i|
  Food.create!(
    name: "卵豆腐#{i}",
    protein: rand(1..10) ,
    quantity: "1",
    unit: "個",
    user_id: i
  )
end

40.times do |i|
  record.create!(
    ate: 1,
    record_on: "Wed, 09 Jun 2021" ,
    food_id: i,
    user_id: i + 1
  )
end

40.times do |i|
  Friendship.create!(
    follower_id: 1,
    followed_id: i + 1,
  )
end