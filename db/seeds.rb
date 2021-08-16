require "date"

ActiveRecord::Base.transaction do
  User.create!(
    email: 'a@example.com',
    name: 'ユーザーa',
    password: 'aaaaaa',
    password_confirmation: 'aaaaaa',
    admin: true
  )

  # usersテーブル
  20.times do |i|
    User.create!(
      email: "#{i}@example.com",
      name: "ユーザー#{i}",
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
  end

  password = SecureRandom.urlsafe_base64
  User.create!(
    email: 'guest@guest.com',
    name: 'guest',
    profile_comment: 'ゲストユーザーです。宜しくお願いします。',
    protein_target: 90,
    password: password,
    password_confirmation: password,
    admin: false
  )

  # foodsテーブル
  guest_user_id = User.find_by("email = ?", "guest@guest.com").id
  user_ids = [ User.first.id,  User.first.id + 1,  User.first.id + 2 , guest_user_id]
  index = 0
  4.times do |j|
    Food.create!(
      name: '豆腐',
      protein: 6,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '納豆',
      protein: 4,
      quantity: 1,
      unit: 'パック',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '卵',
      protein: 4,
      quantity: 1,
      unit: '個',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '鳥もも肉',
      protein: 12,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '鳥むね肉',
      protein: 20,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '鳥ささみ',
      protein: 11,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'ローストビーフ',
      protein: 36,
      quantity: 170,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'エビ',
      protein: 17,
      quantity: 6,
      unit: '尾',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'いくら',
      protein: 16,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '焼きたらこ',
      protein: 14,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'するめ',
      protein: 35,
      quantity: 50,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'きな粉',
      protein: 4,
      quantity: 10,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'がんもどき',
      protein: 15,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '牛乳',
      protein: 6,
      quantity: 200,
      unit: 'ml',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '豆乳',
      protein: 8,
      quantity: 200,
      unit: 'ml',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'ヨーグルト',
      protein: 4,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'カマンベールチーズ',
      protein: 19,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'パルメザンチーズ',
      protein: 44,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'チェダーチーズ',
      protein: 26,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'ゴーダチーズ',
      protein: 25,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'ブルーチーズ',
      protein: 19,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'スライスチーズ',
      protein: 3,
      quantity: 1,
      unit: '枚',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '白米',
      protein: 6,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: '玄米',
      protein: 7,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    Food.create!(
      name: 'オートミール',
      protein: 14,
      quantity: 100,
      unit: 'g',
      user_id: user_ids[index]
    )
    index += 1
  end

  # nutrition_recordsテーブル
  first_user_id =  User.first.id
  second_user_id = User.second.id
  third_user_id = User.third.id
  day = Date.today

  30.times do |k|
    NutritionRecord.create!(
      start_time: day,
      user_id: first_user_id
    )
    NutritionRecord.create!(
      start_time: day,
      user_id: second_user_id
    )
    NutritionRecord.create!(
      start_time: day,
      user_id: third_user_id
    )
    NutritionRecord.create!(
      start_time: day,
      user_id: guest_user_id
    )
    day = day.tomorrow
  end

  # nutrition_record_linesテーブル
  first_user_food_first = Food.where("user_id = ?", first_user_id).first.id
  first_user_food_last = Food.where("user_id = ?", first_user_id).last.id
  second_user_food_first = Food.where("user_id = ?", second_user_id).first.id
  second_user_food_last = Food.where("user_id = ?", second_user_id).last.id
  third_user_food_first = Food.where("user_id = ?", third_user_id).first.id
  third_user_food_last = Food.where("user_id = ?", third_user_id).last.id
  guest_user_food_first = Food.where("user_id = ?", guest_user_id).first.id
  guest_user_food_last = Food.where("user_id = ?", guest_user_id).last.id
  first_user_nutrition_records = NutritionRecord.where("user_id = ?", first_user_id)
  second_user_nutrition_records = NutritionRecord.where("user_id = ?", second_user_id)
  third_user_nutrition_records = NutritionRecord.where("user_id = ?", third_user_id)
  guest_user_nutrition_records = NutritionRecord.where("user_id = ?", guest_user_id)

  day = Date.today
  30.times do |l|
    3.times do |ll|
      NutritionRecordLine.create!(
        ate: Random.rand(1..3),
        food_id: Random.rand(first_user_food_first..first_user_food_last),
        nutrition_record_id: first_user_nutrition_records.find_by("start_time = ?", day).id
      )
      NutritionRecordLine.create!(
        ate: Random.rand(1..3),
        food_id: Random.rand(second_user_food_first..second_user_food_last),
        nutrition_record_id: second_user_nutrition_records.find_by("start_time = ?", day).id
      )
      NutritionRecordLine.create!(
        ate: Random.rand(1..3),
        food_id: Random.rand(third_user_food_first..third_user_food_last),
        nutrition_record_id: third_user_nutrition_records.find_by("start_time = ?", day).id
      )
      NutritionRecordLine.create!(
      ate: Random.rand(1..3),
      food_id: Random.rand(guest_user_food_first..guest_user_food_last),
      nutrition_record_id: guest_user_nutrition_records.find_by("start_time = ?", day).id
      )
    end
    day = day.tomorrow
  end

  # friendshipsテーブル
  15.times do |m|
    Friendship.create!(
      follower_id: User.first.id,
      followed_id: User.second.id + 2 + m
    )
    Friendship.create!(
      follower_id: guest_user_id,
      followed_id: User.second.id + 2 + m
    )
  end

  # bmisテーブル
  day = Date.today
  first_user_height = 150
  second_user_height = 160
  third_user_height = 170
  guest_user_height = 180

  30.times do |n|
    day = day.tomorrow
    first_user_weight = Random.rand(50..54)
    second_user_weight = Random.rand(55..59)
    third_user_weight = Random.rand(63..68)
    guest_user_weight = Random.rand(70..75)
    Bmi.create!(
      height: first_user_height,
      weight: first_user_weight,
      bmi: (first_user_weight/((first_user_height/100.0) ** 2).to_f).round(1),
      record_on: day,
      user_id: first_user_id
    )
    Bmi.create!(
      height: second_user_height,
      weight: second_user_weight,
      bmi: (second_user_weight/((second_user_weight/100.0) ** 2).to_f).round(1),
      record_on: day,
      user_id: second_user_id
    )
    Bmi.create!(
      height: third_user_height,
      weight: third_user_weight,
      bmi: (third_user_weight/((third_user_height/100.0) ** 2).to_f).round(1),
      record_on: day,
      user_id: third_user_id
    )
    Bmi.create!(
      height: guest_user_height,
      weight: guest_user_weight,
      bmi: (guest_user_weight/((guest_user_height/100.0) ** 2).to_f).round(1),
      record_on: day,
      user_id: guest_user_id
    )
  end

  # contactsテーブル
  5.times do |o|
    Contact.create!(
      title: "title#{o}",
      content: "質問#{o}",
      user_id: second_user_id
    )
    Contact.create!(
      title: "title#{o}",
      content: "質問#{o}",
      user_id: guest_user_id
    )
  end

  # repliesテーブル
  10.times do |o|
    Reply.create!(
      comment: "返答#{o}",
      contact_id: Contact.first.id,
      user_id: first_user_id
    )
    Reply.create!(
      comment: "質問#{o}",
      contact_id: Contact.first.id,
      user_id: second_user_id
    )
    Reply.create!(
      comment: "返答#{o}",
      contact_id: Contact.find_by("user_id = ?", guest_user_id).id,
      user_id: first_user_id
    )
    Reply.create!(
      comment: "質問#{o}",
      contact_id: Contact.find_by("user_id = ?", guest_user_id).id,
      user_id: guest_user_id
    )
  end
end