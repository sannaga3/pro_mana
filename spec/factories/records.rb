FactoryBot.define do
  factory :record do
    ate { 1 }
    record_on { "2021-06-05" }
    association :user
    association :food
  end

  factory :secind_record, class Record do
    ate { 2 }
    record_on { "2021-06-06" }
    association :user
    association :second_food
  end

  factory :third_record, class Record do
    ate { 1 }
    record_on { "2021-06-07" }
    association :second_user
    association :food
  end

  factory :fourth_record, class Record do
    ate { 2 }
    record_on { "2021-06-08" }
    association :second_user
    association :second_food
  end
end
