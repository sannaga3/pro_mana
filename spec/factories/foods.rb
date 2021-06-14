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
end
