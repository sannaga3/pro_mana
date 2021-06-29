FactoryBot.define do
  factory :record, class: Record do
    ate { 1 }
    start_time { '2021-06-05' }
    food_id { Food.find_by(name: '納豆').id }
    user_id { User.find_by(name: 'すだまさき').id }
  end

  factory :second_record, class: Record do
    ate { 1 }
    start_time { '2021-06-06' }
    food_id { Food.find_by(name: '卵').id }
    user_id { User.find_by(name: 'すだまさき').id }
  end

  factory :third_record, class: Record do
    ate { 1 }
    start_time { '2021-06-05' }
    food_id { Food.find_by(name: '豆腐').id }
    user_id { User.find_by(name: 'garnetcrow').id }
  end

  factory :fourth_record, class: Record do
    ate { 2 }
    start_time { '2021-06-07' }
    food_id { Food.find_by(name: '豆腐').id }
    user_id { User.find_by(name: 'garnetcrow').id }
  end

  factory :fifth_record, class: Record do
    ate { 2 }
    start_time { '2021-06-07' }
    food_id { Food.find_by(name: '鳥もも肉').id }
    user_id { User.find_by(name: 'SUPER BEAVER').id }
  end
end
