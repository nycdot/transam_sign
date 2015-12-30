FactoryGirl.define do

  factory :sign_standard do
    asset_subtype_id 1
    smo_code 'R-116'
    size_description '24 x 36'
    sign_description 'Railroad crossing sign'
    association :sign_standard_type
  end

end
