require 'rails_helper'

RSpec.describe Sign, :type => :model do

  let(:test_sign)         { build_stubbed(:sign) }
  let(:persisted_sign)    { create(:sign) }


  describe 'associations' do
    it 'has a sign standard' do
      expect(test_sign).to belong_to(:sign_standard)
    end
    it 'has a sheeting type' do
      expect(test_sign).to belong_to(:sheeting_type)
    end
    it 'has a blank type' do
      expect(test_sign).to belong_to(:blank_type)
    end
    it 'has a sign legend color type' do
      expect(test_sign).to belong_to(:sign_legend_color_type)
    end
    it 'has a sign background color type' do
      expect(test_sign).to belong_to(:sign_background_color_type)
    end
    it 'has a support type' do
      expect(test_sign).to belong_to(:support_type)
    end
    it 'has a support size type' do
      expect(test_sign).to belong_to(:support_size_type)
    end
    it 'has a support condition type' do
      expect(test_sign).to belong_to(:support_condition_type)
    end
    it 'has a travel direction type' do
      expect(test_sign).to belong_to(:travel_direction_type)
    end
    it 'has a facing direction type' do
      expect(test_sign).to belong_to(:facing_direction_type)
    end
    it 'has a arrow direction type' do
      expect(test_sign).to belong_to(:arrow_direction_type)
    end
    it 'has a side of road type' do
      expect(test_sign).to belong_to(:side_of_road_type)
    end
  end

  describe 'validations' do
    it 'must have a sign standard to save' do
      persisted_sign.sign_standard = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.sign_standard = build_stubbed(:sign_standard)
      expect(persisted_sign).to be_valid
    end

    # it 'must have a sheeting type to save' do
    #   persisted_sign.sheeting_type_id = nil
    #   expect(persisted_sign).not_to be_valid
    #
    #   persisted_sign.sheeting_type_id = 1
    #   expect(persisted_sign).to be_valid
    # end
    #
    # it 'must have a blank type to save' do
    #   persisted_sign.blank_type_id = nil
    #   expect(persisted_sign).not_to be_valid
    #
    #   persisted_sign.blank_type_id = 1
    #   expect(persisted_sign).to be_valid
    # end
    #
    # it 'must have a travel direction type to save' do
    #   persisted_sign.travel_direction_type_id = nil
    #   expect(persisted_sign).not_to be_valid
    #
    #   persisted_sign.travel_direction_type_id = 1
    #   expect(persisted_sign).to be_valid
    # end
    #
    # it 'must have a facing direction type to save' do
    #   persisted_sign.facing_direction_type_id = nil
    #   expect(persisted_sign).not_to be_valid
    #
    #   persisted_sign.facing_direction_type_id = 1
    #   expect(persisted_sign).to be_valid
    # end
    #
    # it 'must have a side of road type to save' do
    #   persisted_sign.side_of_road_type_id = nil
    #   expect(persisted_sign).not_to be_valid
    #
    #   persisted_sign.side_of_road_type_id = 1
    #   expect(persisted_sign).to be_valid
    # end

    it 'must have a distance from intersection to save' do
      persisted_sign.distance_from_intersection = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.distance_from_intersection = 'a'
      expect(persisted_sign).not_to be_valid

      persisted_sign.distance_from_intersection = -1
      expect(persisted_sign).not_to be_valid

      persisted_sign.distance_from_intersection = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a lateral offset to save' do
      persisted_sign.lateral_offset = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.lateral_offset = 'a'
      expect(persisted_sign).not_to be_valid

      persisted_sign.lateral_offset = -1
      expect(persisted_sign).not_to be_valid

      persisted_sign.lateral_offset = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a street name to save' do
      persisted_sign.street_name = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.street_name = "123 Main St"
      expect(persisted_sign).to be_valid
    end

  end

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------

  it '#allowable_params' do
    expect(Sign.allowable_params).to eq([
      :sign_standard_id,
      :blank_type_id,
      :sheeting_type_id,
      :sign_legend_color_type_id,
      :sign_background_color_type_id,
      :street_name,
      :lateral_offset,
      :distance_from_intersection,
      :side_of_road_type_id,
      :facing_direction_type_id,
      :travel_direction_type_id,
      :arrow_direction_type_id,
      :support_type_id,
      :support_size_type_id,
      :support_condition_type_id,
      :support_in_service_date
    ])
  end

  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------

  describe '.type_of' do
    it 'inherits from asset' do
      expect(test_sign.type_of? :asset).to be true
    end
  end

  describe '.age' do
    it 'in service' do
      expect(test_sign.age(Date.new(2010,1,1))).to eq(9)
    end
    it 'rehabilitation' do
      test_sign.last_rehabilitation_date = Date.new(2005,1,1)
      expect(test_sign.age(Date.new(2010,1,1))).to eq(5)
    end
  end
  it '.smo' do
    expect(test_sign.smo).to eq(test_sign.sign_standard.smo_code)
  end
  it '.legend' do
    expect(test_sign.legend).to eq(test_sign.sign_standard.sign_description)
  end
  it '.size' do
    expect(test_sign.size).to eq(test_sign.sign_standard.size_description)
  end
  it '.description' do
    expect(test_sign.description).to eq(test_sign.sign_standard.to_s)
  end
  describe '.install_date' do
    it 'equals in service date' do
      expect(test_sign.install_date).to eq(test_sign.in_service_date)
    end
  end
  describe '.name' do
    it 'is the same as the description' do
      expect(test_sign.name).to eq(test_sign.description)
    end
  end
  describe '.cost' do
    it 'is the same as purchase cost' do
      expect(test_sign.cost).to eq(test_sign.purchase_cost)
    end
  end
  it '.searchable_fields' do
    Sign::SEARCHABLE_FIELDS.each do |field|
      expect(test_sign.searchable_fields).to include(field)
    end
  end
  it '.cleansable_fields' do
    Sign::CLEANSABLE_FIELDS.each do |field|
      expect(test_sign.cleansable_fields).to include(field)
    end
  end

  describe '.set_defaults' do
    it 'initializes new objects correctly' do
      expect(test_sign.distance_from_intersection).to eq(0)
      expect(test_sign.lateral_offset).to eq(0)
    end
  end

end
