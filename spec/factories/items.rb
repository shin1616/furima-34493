FactoryBot.define do
  factory :item do
    association :user
    name          { Faker::Name.initials(number: 5) }
    text          { Faker::Name.initials(number: 5) }
    category_id   { Faker::Number.within(range: 2..11) }
    status_id     { Faker::Number.within(range: 2..7) }
    postage_id    { Faker::Number.within(range: 2..3) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    period_id     { Faker::Number.within(range: 2..4) }
    price         { Faker::Number.within(range: 300..9_999_999) }
  end
end
