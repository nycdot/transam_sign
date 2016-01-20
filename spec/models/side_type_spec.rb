require 'rails_helper'

RSpec.describe SideType, :type => :model do

  let(:test_type) { SideType.first }

  it '.to_s' do
    expect(test_type.to_s).to eq(test_type.code)
  end
end
