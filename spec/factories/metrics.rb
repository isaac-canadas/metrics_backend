FactoryBot.define do
  factory :metric do
    name { Faker::Lorem.word }
    value { Faker::Number.number(digits: 10) }
  end
end