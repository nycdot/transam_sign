require 'rails_helper'

RSpec.describe MileageUpdateEvent, :type => :model do

  let(:test_event) { create(:mileage_update_event) }

  before(:each) do
    ServiceVehicle.destroy_all
  end

  describe 'associations' do
    it 'belongs to an asset' do
      expect(test_event).to belong_to(:asset)
    end
    it 'is a type of asset event' do
      expect(test_event).to belong_to(:asset_event_type)
    end
    it 'can be related to an upload' do
      expect(test_event).to belong_to(:upload)
    end
  end

  describe 'validations' do
    # it 'must have an asset' do
    #   test_event.asset = nil
    #   expect(test_event.valid?).to be false
    # end
    it 'must have an asset event type' do
      test_event.asset_event_type = nil
      expect(test_event.valid?).to be false
    end
    it 'must have a current mileage' do
      test_event.current_mileage = nil
      expect(test_event.current_mileage).to eq(100000)
      test_event.current_mileage = -10
      expect(test_event.current_mileage).to eq(10)
      test_event.current_mileage = 0
      expect(test_event.current_mileage).to eq(0)
    end
    it 'event date with purchase' do
      expect(test_event.valid?).to be true
      test_event.asset.update!(:purchase_date => Date.today + 1.year)
      expect(test_event.valid?).to be false
    end
    it 'monotonically increasing mileage' do
      test_org = create(:organization)
      test_vehicle = create(:service_vehicle, :organization => test_org, :title_owner => test_org)
      test_vehicle.asset_events << test_event
      test_vehicle.save!
      expect(test_event.valid?).to be true
      test_event2 = create(:mileage_update_event, :asset => test_vehicle, :event_date => Date.today+1.day)
      expect(test_event2.valid?).to be true
      test_event2.current_mileage = 1
      expect(test_event2.valid?).to be false
      test_event2.current_mileage = 99999999999
      expect(test_event2.valid?).to be true
    end
  end

  describe 'class methods' do
    it '#allowable_params' do
      expect(MileageUpdateEvent.allowable_params).to eq([:current_mileage])
    end
    it '#asset_event_type' do
      expect(MileageUpdateEvent.asset_event_type).to eq(AssetEventType.find_by(:class_name => 'MileageUpdateEvent'))
    end
  end

  it '.get_update' do
    expect(test_event.get_update).to eq("Mileage recorded as #{test_event.current_mileage}.")
  end

  it '.set_defaults' do
    expect(test_event.event_date).to eq(Date.today)
    expect(test_event.asset_event_type).to eq(AssetEventType.find_by(:class_name => 'MileageUpdateEvent'))
  end
end
