FactoryGirl.define do
  factory :address do
    address_id        { 1 + rand(10000) }
    parcel_id         { 1 + rand(20000) }
    geopin            { 1 + rand(30000) }
  end
end
