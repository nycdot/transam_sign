require 'rails_helper'

RSpec.describe ServiceVehicle, :type => :model do

  let(:test_service_vehicle)   { build_stubbed(:service_vehicle_with_crew) }

  #------------------------------------------------------------------------------
  #
  # Associations
  #
  #------------------------------------------------------------------------------

  it 'belongs to an organization' do
    expect(test_service_vehicle).to belong_to(:organization)
  end

  it 'has many crew members' do
    expect(test_service_vehicle).to have_many(:crew_members)
  end

  it 'has many users' do
    expect(test_service_vehicle).to have_many(:users)
  end

  it 'has many comments' do
    expect(test_service_vehicle).to have_many(:comments)
  end

  it 'has many documents' do
    expect(test_service_vehicle).to have_many(:documents)
  end

  #------------------------------------------------------------------------------
  #
  # Validations
  #
  #------------------------------------------------------------------------------

  it 'must have an organization' do
    test_service_vehicle.organization = nil
    expect(test_service_vehicle.valid?).to be false
  end

  it 'must have a license plate' do
    test_service_vehicle.license_plate = nil
    expect(test_service_vehicle.valid?).to be false
  end

  it 'must have a VIN' do
    test_service_vehicle.serial_number = nil
    expect(test_service_vehicle.valid?).to be false
  end

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

  it 'has a supervisor' do
    expect(test_service_vehicle.supervisor).to eq(test_service_vehicle.crew_members.find_by(:supervisor => true))
  end
end
