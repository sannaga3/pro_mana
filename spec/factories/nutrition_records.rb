FactoryBot.define do
  # factory :record, class: NutritionRecord do
  #   ate { 1 }
  #   start_time { '2021-06-05' }
  #   food_id { Food.find_by(name: '納豆').id }
  #   user_id { User.find_by(name: 'すだまさき').id }
  # end

  # factory :second_record, class: NutritionRecord do
  #   ate { 1 }
  #   start_time { '2021-06-06' }
  #   food_id { Food.find_by(name: '卵').id }
  #   user_id { User.find_by(name: 'すだまさき').id }
  # end

  # factory :third_record, class: NutritionRecord do
  #   ate { 1 }
  #   start_time { '2021-06-05' }
  #   food_id { Food.find_by(name: '豆腐').id }
  #   user_id { User.find_by(name: 'garnetcrow').id }
  # end

  # factory :fourth_record, class: NutritionRecord do
  #   ate { 2 }
  #   start_time { '2021-06-07' }
  #   food_id { Food.find_by(name: '豆腐').id }
  #   user_id { User.find_by(name: 'garnetcrow').id }
  # end

  # factory :fifth_record, class: NutritionRecord do
  #   ate { 2 }
  #   start_time { '2021-06-07' }
  #   food_id { Food.find_by(name: '鳥もも肉').id }
  #   user_id { User.find_by(name: 'SUPER BEAVER').id }
  # end

  factory :record, class: NutritionRecord do
    start_time { '2021-06-05' }
    user_id { User.find_by(name: 'すだまさき').id }
    after(:build) do |record|
      record.nutrition_record_lines << FactoryBot.build(:nutrition_record_line, nutrition_record: record)
    end
  end

  factory :second_record, class: NutritionRecord do
    start_time { '2021-06-06' }
    user_id { User.find_by(name: 'すだまさき').id }
    after(:build) do |second_record|
      second_record.nutrition_record_lines << FactoryBot.build(:nutrition_record_line, nutrition_record: second_record)
    end
  end

  factory :nutrition_record_line, class: NutritionRecordLine do
    ate { 1 }
    food { Food.find_by(name: '納豆') }
  end

  factory :second_nutrition_record_line, class: NutritionRecordLine do
    ate { 2 }
    food { Food.find_by(name: '卵') }
  end
end
