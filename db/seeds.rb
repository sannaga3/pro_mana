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

3.times do |j|
  Food.create!(
    name: "豆腐",
    protein: 6,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "納豆",
    protein: 4,
    quantity: 1,
    unit: "パック",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "卵",
    protein: 4,
    quantity: 1,
    unit: "個",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "鳥もも肉",
    protein: 12,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "鳥むね肉",
    protein: 20,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "鳥ささみ",
    protein: 11,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "ローストビーフ",
    protein: 36,
    quantity: 170,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "エビ",
    protein: 17,
    quantity: 6,
    unit: "尾",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "いくら",
    protein: 16,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "焼きたらこ",
    protein: 14,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "するめ",
    protein: 35,
    quantity: 50,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "きな粉",
    protein: 4,
    quantity: 10,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "がんもどき",
    protein: 15,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "牛乳",
    protein: 6,
    quantity: 200,
    unit: "ml",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "豆乳",
    protein: 8,
    quantity: 200,
    unit: "ml",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "ヨーグルト",
    protein: 4,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "カマンベールチーズ",
    protein: 19,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "パルメザンチーズ",
    protein: 44,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "チェダーチーズ",
    protein: 26,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "ゴーダチーズ",
    protein: 25,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "ブルーチーズ",
    protein: 19,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "スライスチーズ",
    protein: 3,
    quantity: 1,
    unit: "枚",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "白米",
    protein: 6,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "玄米",
    protein: 7,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
  Food.create!(
    name: "オートミール",
    protein: 14,
    quantity: 100,
    unit: "g",
    user_id: User.first.id + j
  )
end






first_user_id =  User.first.id
second_user_id = User.second.id
third_user_id = User.third.id
first_user_food_first = Food.where(user_id: first_user_id).first.id
first_user_food_last = Food.where(user_id: first_user_id).last.id
second_user_food_first = Food.where(user_id: second_user_id).first.id
second_user_food_last = Food.where(user_id: second_user_id).last.id
third_user_food_first = Food.where(user_id: third_user_id).first.id
third_user_food_last = Food.where(user_id: third_user_id).last.id
30.times do |m|
  d1 = Date.parse("2021/06/01")
  d2 = Date.parse("2021/06/15")
  date = Random.rand(d1..d2)
  Record.create!(
    ate: Random.rand(1..3),
    record_on: date,
    food_id: Random.rand(first_user_food_first..first_user_food_last),
    user_id: first_user_id
  )
  Record.create!(
    ate: Random.rand(1..3),
    record_on: date,
    food_id: Random.rand(second_user_food_first..second_user_food_last),
    user_id: second_user_id
  )
  Record.create!(
    ate: Random.rand(1..3),
    record_on: date,
    food_id: Random.rand(third_user_food_first..third_user_food_last),
    user_id: third_user_id
  )
end

15.times do |l|
  Friendship.create!(
    follower_id: User.first.id,
    followed_id: User.second.id + 2 + l,
  )
end