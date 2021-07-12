FactoryBot.define do
  factory :bmi do
    height { 160 }
    weight { 55}
    record_on { '2021-07-01' }
  end

  factory :second_bmi, class: Bmi do
    height { 160 }
    weight { 56}
    record_on { '2021-07-02' }
  end
end
