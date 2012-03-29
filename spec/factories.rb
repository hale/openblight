FactoryGirl.define do
  factory :address do
    address_id        { 1 + rand(10000) }
    parcel_id         { 1 + rand(20000) }
    geopin            { 1 + rand(30000) }
  end

  factory :case do
  	case_number			{rand(1000).to_s()}
  end
end
