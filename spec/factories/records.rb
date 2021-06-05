FactoryBot.define do
  factory :record do
    ate { 1 }
    record_on { "2021-06-05" }
    food { nil }
    user { nil }
  end
end
