FactoryGirl.define do
  factory :address do
    address_id        { 1 + rand(10000) }
    parcel_id         { 1 + rand(20000) }
    geopin            { 1 + rand(30000) }
    address_long      { "123 PERDIDO ST" }
    street_type       { "St" }
  end

  factory :case do
    case_number       { "CEHB " + rand(1000).to_s()}
  end

  factory :hearing do
    hearing_date      { Time.now }
  end

  factory :inspection do
    inspection_type   { "Violation Posted No WIP" }
  end
end
