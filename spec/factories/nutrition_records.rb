FactoryBot.define do
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
      second_record.nutrition_record_lines << FactoryBot.build(:second_nutrition_record_line, nutrition_record: second_record)
      second_record.nutrition_record_lines << FactoryBot.build(:fifth_nutrition_record_line, nutrition_record: second_record)
    end
  end

  factory :third_record, class: NutritionRecord do
    start_time { '2021-06-05' }
    user_id { User.find_by(name: 'garnetcrow').id }
    after(:build) do |third_record|
      third_record.nutrition_record_lines << FactoryBot.build(:third_nutrition_record_line, nutrition_record: third_record)
    end
  end

  factory :fourth_record, class: NutritionRecord do
    start_time { '2021-06-07' }
    user_id { User.find_by(name: 'garnetcrow').id }
    after(:build) do |fourth_record|
      fourth_record.nutrition_record_lines << FactoryBot.build(:fourth_nutrition_record_line, nutrition_record: fourth_record)
    end
  end

  factory :fifth_record, class: NutritionRecord do
    start_time { '2021-06-08' }
    user_id { User.find_by(name: 'SUPER BEAVER').id }
    after(:build) do |fifth_record|
      fifth_record.nutrition_record_lines << FactoryBot.build(:fifth_nutrition_record_line, nutrition_record: fifth_record)
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

  factory :third_nutrition_record_line, class: NutritionRecordLine do
    ate { 2 }
    food { Food.find_by(name: '豆腐') }
  end

  factory :fourth_nutrition_record_line, class: NutritionRecordLine do
    ate { 2 }
    food { Food.find_by(name: '豆腐') }
  end

  factory :fifth_nutrition_record_line, class: NutritionRecordLine do
    ate { 1 }
    food { Food.find_by(name: '鳥もも肉') }
  end
end
