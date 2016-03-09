require 'rails_helper'

RSpec.describe AssetMileageUpdateJob, :type => :job do

  let(:test_asset) { create(:service_vehicle) }

  it 'sogr update' do
    expect(AssetMileageUpdateJob.new(0).requires_sogr_update?).to be true
  end

  it '.run' do
    test_event = test_asset.mileage_updates.create!(attributes_for(:mileage_update_event))
    AssetMileageUpdateJob.new(test_asset.object_key).run
    test_asset.reload

    expect(test_asset.reported_mileage_date).to eql(Date.today)
    expect(test_asset.reported_mileage).to eql(100000)
  end

  it '.prepare' do
    test_asset.save!
    allow(Time).to receive(:now).and_return(Time.utc(2000,"jan",1,20,15,1))
    expect(Rails.logger).to receive(:debug).with("Executing AssetMileageUpdateJob at #{Time.now.to_s} for Asset #{test_asset.object_key}")
    AssetMileageUpdateJob.new(test_asset.object_key).prepare
  end
end
