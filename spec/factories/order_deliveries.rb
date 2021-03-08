FactoryBot.define do
  factory :order_delivery do
    token         { 'tok_abcdefghijk00000000000000000' }
    post_number   { '123-4567' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    municipality  { '大阪市' }
    address       { '大阪1-1-1' }
    apartment     { '大阪ハイツ101号室' }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
  end
end