require 'rails_helper'

RSpec.describe VehicleFeature, :type => :model do

  let(:test_feature) { VehicleFeature.first }

  describe '#search' do
    it 'exact' do
      expect(VehicleFeature.search(test_feature.description)).to eq(test_feature)
    end
    it 'partial' do
      expect(VehicleFeature.search(test_feature.description[0..1], false)).to eq(test_feature)
    end
  end

  it '.to_s' do
    expect(test_feature.to_s).to eq(test_feature.name)
  end
end
