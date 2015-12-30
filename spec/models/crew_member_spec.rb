require 'rails_helper'

RSpec.describe CrewMember, :type => :model do

  let(:test_crew) { create(:crew_member) }

  before(:each) do
    ServiceVehicle.destroy_all
  end

  #-----------------------------------------------------------------------------
  # Associations and Validations
  #-----------------------------------------------------------------------------
  describe 'associations' do
    it 'has a service vehicle' do
      expect(test_crew).to belong_to(:service_vehicle)
    end
    it 'is a user' do
      expect(test_crew).to belong_to(:user)
    end
  end
  describe 'validations' do
    it 'must have a service vehicle' do
      test_crew.service_vehicle = nil

      expect(test_crew.valid?).to be false
    end
    it 'must have an user' do
      test_crew.user = nil

      expect(test_crew.valid?).to be false
    end
  end

  describe 'scope' do
    it 'supervisors' do
      test_supervisor = create(:crew_member, :supervisor => true)
      test_crew = create(:crew_member, :supervisor => false)
      expect(CrewMember.supervisors).to include(test_supervisor)
      expect(CrewMember.supervisors).not_to include(test_crew)
    end
    it 'crew' do
      test_supervisor = create(:crew_member, :supervisor => true)
      test_crew = create(:crew_member, :supervisor => false)
      expect(CrewMember.crew).not_to include(test_supervisor)
      expect(CrewMember.crew).to include(test_crew)
    end
  end

  #-----------------------------------------------------------------------------
  # Class Methods
  #-----------------------------------------------------------------------------

  it '#allowable_params' do
    expect(CrewMember.allowable_params).to eq([:asset_id, :user_id])
  end

  #-----------------------------------------------------------------------------
  # Instance Methods
  #-----------------------------------------------------------------------------
end
