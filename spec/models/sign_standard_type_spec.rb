require 'rails_helper'

RSpec.describe SignStandardType, :type => :model do

  let(:test_type) { create(:sign_standard_type) }

  describe 'associations' do
    it 'belongs to an asset subtype' do
      expect(test_type).to belong_to(:asset_subtype)
    end
    it 'has many standards' do
      expect(test_type).to have_many(:sign_standards)
    end
  end

  it '.to_s' do
    expect(test_type.to_s).to eq(test_type.name)
  end

end
