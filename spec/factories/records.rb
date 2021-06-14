FactoryBot.define do
  factory :user_one, class: User do
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

  factory :user_two, class: User do
    name { 'garnetcrow' }
    email { 'wasurezaki@example.com' }
    password { 'natunomaboroshi' }
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/.jpg'))}
    profile_comment { 'ボーカルの中村です、コナンの曲歌ってました。解散後ソロで活動しています' }
    height { '156' }
    weight { '49' }
    protein_target { '75' }
    admin { 'false' }
  end

  factory :food_one, class: Food do
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
