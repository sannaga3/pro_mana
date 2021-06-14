FactoryBot.define do
  factory :first_user, class: User do
    name { 'すだまさき' }
    email { 'machigaisagasi@example.com' }
    password { 'sayonaraerezi' }
    profile_image { '' }
    profile_comment { '趣味は服を買うことです。あと有村〇〇にギターを教えることです' }
    height { 172 }
    weight { 63 }
    protein_target { 95 }
    admin { 'true' }
  end

  factory :first_food, class: Food do
    name { "chicken" }
    protein { 12 }
    quantity { 1 }
    unit { "本" }
    user_id { User.find_by(name: "すだまさき").id }
  end

  factory :record, class: Record do
    ate { 1 }
    record_on { "2021-06-05" }
    food_id { Food.find_by(name: "chicken").id }
    user_id { User.find_by(name: "すだまさき").id }
  end

  # factory :secind_record, class: Record do
  #   ate { 2 }
  #   record_on { "2021-06-06" }
  #   association :user
  #   association :second_food
  # end

  # factory :third_record, class: Record do
  #   ate { 1 }
  #   record_on { "2021-06-07" }
  #   association :second_user
  #   association :food
  # end

  # factory :fourth_record, class: Record do
  #   ate { 2 }
  #   record_on { "2021-06-08" }
  #   association :second_user
  #   association :second_food
  # end
end
