User.create!(
  email: "a@example.com",
  name: "ユーザーa",
  password: "aaaaaa",
  admin: true
)

20.times do |i|
  User.create!(
    email: "#{i}@example.com",
    name: "ユーザー#{i}",
    password: "aaaaaa",
    admin: false
  )
end

5.times do |n|
  Food.create!(
    name: "豆腐#{n}",
    protein: rand(1..10) ,
    quantity: 1,
    unit: "丁",
    user_id: User.first.id
  )
  Food.create!(
    name: "納豆#{n}",
    protein: rand(1..10) ,
    quantity: 1,
    unit: "パック",
    user_id: User.first.id
  )
  Food.create!(
    name: "卵#{n}",
    protein: rand(1..10) ,
    quantity: 1,
    unit: "個",
    user_id: User.first.id
  )
end

3.times do |m|
  Record.create!(
    ate: 1,
    record_on: "2021-06-07",
    food_id: Food.first.id + m,
    user_id: User.first.id + m
  )
  Record.create!(
    ate: 2,
    record_on: "2021-06-08",
    food_id: Food.first.id + m,
    user_id: User.first.id + m
  )
  Record.create!(
    ate: 1,
    record_on: "2021-06-09",
    food_id: Food.first.id + m,
    user_id: User.first.id + m
  )
  Record.create!(
    ate: 3,
    record_on: "2021-06-10",
    food_id: Food.first.id + m,
    user_id: User.first.id + m
  )
end

15.times do |l|
  Friendship.create!(
    follower_id: User.first.id,
    followed_id: User.second.id + 2 + l,
  )
end