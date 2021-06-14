FactoryBot.define do
  factory :food do
    name { '納豆' }
    protein { '4' }
    quantity { '1' }
    unit { 'パック' }
    association :user
  end

  factory :second_food, class: Food do
    name { '卵' }
    protein { '4' }
    quantity { '1' }
    unit { '個' }
    association :user
  end

  factory :third_food, class: Food do
    name { '豆腐' }
    protein { '6' }
    quantity { '100' }
    unit { 'g' }
    association :second_user
  end
end
