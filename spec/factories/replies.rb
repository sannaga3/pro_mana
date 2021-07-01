FactoryBot.define do
  factory :reply do
    comment { "MyText" }
    replyer_id { 1 }
    contact { nil }
  end
end
