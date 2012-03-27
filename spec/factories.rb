FactoryGirl.define do
  factory :address do
    address_id        { 1 + rand(10000) }
  end
end