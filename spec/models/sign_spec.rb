require 'rails_helper'

RSpec.describe Sign, :type => :model do

  let(:test_sign)         { build_stubbed(:sign) }
  let(:persisted_sign)    { create(:sign) }

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------


  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------

  describe '#set_defaults' do
    it 'initializes new objects correctly' do
      expect(test_sign.distance_from_intersection).to eq(0)
      expect(test_sign.lateral_offset).to eq(0)
    end
  end

  describe '#validates' do
    it 'must have a sign standard to save' do
      persisted_sign.sign_standard = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.sign_standard = build_stubbed(:sign_standard)
      expect(persisted_sign).to be_valid
    end

    it 'must have a sheeting type to save' do
      persisted_sign.sheeting_type_id = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.sheeting_type_id = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a blank type to save' do
      persisted_sign.blank_type_id = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.blank_type_id = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a travel direction type to save' do
      persisted_sign.travel_direction_type_id = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.travel_direction_type_id = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a facing direction type to save' do
      persisted_sign.facing_direction_type_id = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.facing_direction_type_id = 1
      expect(persisted_sign).to be_valid
    end

    it 'must have a side of road type to save' do
      persisted_sign.side_of_road_type_id = nil
      expect(persisted_sign).not_to be_valid

      persisted_sign.side_of_road_type_id = 1
      expect(persisted_sign).to be_valid
    end

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

  describe '#type_of' do
    it 'inherits from asset' do
      expect(test_sign.type_of? :asset).to be true
    end
  end

  describe '#name' do
    it 'is the same as the description' do
      expect(test_sign.name).to eq(test_sign.description)
    end
  end

  describe '#install_date' do
    it 'equals in service date' do
      expect(test_sign.install_date).to eq(test_sign.in_service_date)
    end
  end

  describe '#cost' do
    it 'is the same as purchase cost' do
      expect(test_sign.cost).to eq(test_sign.purchase_cost)
    end
  end

end
