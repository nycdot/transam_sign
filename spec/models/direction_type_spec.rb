require 'rails_helper'

RSpec.describe DirectionType, :type => :model do

  let(:test_type) { DirectionType.first }

  it '.to_s' do
    expect(test_type.to_s).to eq(test_type.name)
  end
end
