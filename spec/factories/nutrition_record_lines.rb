FactoryBot.define do
  factory :nutrition_record_line do
    ate { 1 }
    nutrition_record { nil }
    food { nil }
  end
end
