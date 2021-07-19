FactoryBot.define do
  factory :contact do
    title { "メレブはスイーツを覚えた" }
    content { "ヨシピコ「メレブさん、その呪文を私に掛けてください」" }
  end

  factory :second_contact, class: Contact do
    title { "メレブ「戦いの最中、またしても私は新たな呪文を覚えてしまったようだ」" }
    content { "ヨシピコ「そ、それはどんな呪文ですか！？ぜひ私に掛けてください」" }
  end
end