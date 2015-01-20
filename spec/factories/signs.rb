# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :asset_tag do |n|
    "ABS_TAG#{n}"
  end

  trait :basic_asset_attributes do
    association :organization, :factory => :organization
    asset_tag
    purchase_date { 1.year.ago }
    manufacture_year "2000"
    in_service_date Date.new(2001,1,1)
    created_by_id 1
  end

  factory :sign, :class => :sign do
    basic_asset_attributes
    association :asset_type
    association :asset_subtype
    purchase_cost 2000.0
    association :sign_standard
    association :sheeting_type
    association :blank_type
    association :travel_direction_type, :factory => :direction_type
    association :facing_direction_type, :factory => :direction_type
    association :side_of_road_type, :factory => :side_type
    street_name "123 Main St"
  end

end
