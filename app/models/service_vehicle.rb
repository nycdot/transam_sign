#-------------------------------------------------------------------------------
#
# ServiceVehicle
#
# Implementation class for a Service Vehicle asset
#
#-------------------------------------------------------------------------------
class ServiceVehicle < Asset

  # Callbacks
  after_initialize    :set_defaults
  before_validation   :set_description

  # Clean up any HABTM associations before the asset is destroyed
  before_destroy { vehicle_features.clear }

  #-----------------------------------------------------------------------------
  # Associations common to all Service Vehicles
  #-----------------------------------------------------------------------------

  # each asset has zero or more mileage updates. Only for vehicle assets.
  has_many    :mileage_updates, -> {where :asset_event_type_id => MileageUpdateEvent.asset_event_type.id }, :foreign_key => :asset_id, :class_name => "MileageUpdateEvent"

  # each service vehicle has a type of fuel
  belongs_to  :fuel_type

  # each service vehicle's title is owned by an organization
  belongs_to  :title_owner,         :class_name => "Organization", :foreign_key => 'title_owner_organization_id'

  # Each service vehicle has a set (0 or more) of vehicle features
  has_and_belongs_to_many   :vehicle_features,    :foreign_key => 'asset_id'

  # Each service vehicle has a crew that is assigned to it
  has_many    :crew_members,  :foreign_key => :asset_id, :dependent => :destroy
  has_many    :users, :through => :crew_members

  #-----------------------------------------------------------------------------
  # Service Vehicle Physical Characteristics
  #-----------------------------------------------------------------------------
  validates :license_plate,               :presence => :true
  validates :seating_capacity,            :presence => :true, :numericality => {:only_integer => :true, :greater_than_or_equal_to => 1}
  validates :fuel_type,                   :presence => :true
  validates :serial_number,               :presence => :true
  validates :gross_vehicle_weight,        :allow_nil => true, :numericality => {:only_integer => :true,   :greater_than_or_equal_to => 0}
  validates :manufacturer_id,             :presence => :true
  validates :manufacturer_model,          :presence => :true
  validates :title_owner_organization_id, :presence => :true
  validates :vehicle_length,              :presence => :true, :numericality => {:only_integer => :true, :greater_than => 0}

  #-----------------------------------------------------------------------------
  # Scopes
  #-----------------------------------------------------------------------------
  # set the default scope
  default_scope { where(:asset_type_id => AssetType.find_by_class_name(self.name).id) }

  #-----------------------------------------------------------------------------
  # Lists. These lists are used by derived classes to make up lists of attributes
  # that can be used for operations like full text search etc. Each derived class
  # can add their own fields to the list
  #-----------------------------------------------------------------------------

  SEARCHABLE_FIELDS = [
    'license_plate',
    'serial_number'
  ]
  CLEANSABLE_FIELDS = [
    'license_plate',
    'serial_number'
  ]
  UPDATE_METHODS = [
    :update_mileage
  ]

  # List of hash parameters specific to this class that are allowed by the controller
  FORM_PARAMS = [
    :seating_capacity,
    :license_plate,
    :serial_number,
    :gross_vehicle_weight
  ]

  #-----------------------------------------------------------------------------
  #
  # Class Methods
  #
  #-----------------------------------------------------------------------------

  def self.allowable_params
    FORM_PARAMS
  end
  def self.update_methods
    UPDATE_METHODS
  end

  #-----------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #-----------------------------------------------------------------------------

  # Crew members not including the supervisor
  def crew
    a = []
    crew_members.crew.each {|x| a << x.user}
    a
  end

  # Returns the crew member who is designated as the supervisor
  def supervisor
    crew_members.supervisors.first.user unless crew_members.supervisors.empty?
  end

  # Render the asset as a JSON object -- overrides the default json encoding
  def as_json(options={})
    super.merge(
    {
      :reported_mileage => self.reported_mileage,
      :seating_capacity => self.seating_capacity,
      :license_plate => self.license_plate,
      :serial_number => self.serial_number,
      :vehicle_length => self.vehicle_length,
      :gross_vehicle_weight => self.gross_vehicle_weight,
      :description => self.description,
      :title_number => self.title_number,
      :title_owner_organization_id => self.title_owner.present? ? self.title_owner.to_s : nil,
      :fuel_type_id => self.fuel_type.present? ? self.fuel_type.to_s : nil
    })
  end


  def seating_capacity=(num)
    self[:seating_capacity] = sanitize_to_int(num)
  end

  # Creates a duplicate that has all asset-specific attributes nilled
  def copy(cleanse = true)
    a = dup
    a.cleanse if cleanse
    a
  end

  def searchable_fields
    a = []
    a << super
    SEARCHABLE_FIELDS.each do |field|
      a << field
    end
    a.flatten
  end

  def cleansable_fields
    a = []
    a << super
    CLEANSABLE_FIELDS.each do |field|
      a << field
    end
    a.flatten
  end

  # Forces an update of an assets mileage. This performs an update on the record. If a policy is passed
  # that policy is used to update the asset otherwise the default policy is used
  def update_mileage(policy = nil)

    Rails.logger.info "Updating the recorded mileage method for asset = #{object_key}"

    # can't do this if it is a new record as none of the IDs would be set
    unless new_record?
      # Update the reported mileage
      begin
        if mileage_updates.empty?
          self.reported_mileage = 0
          self.reported_mileage_date = nil
        else
          event = mileage_updates.last
          self.reported_mileage = event.current_mileage
          self.reported_mileage_date = event.event_date
        end
        save
      rescue Exception => e
        Rails.logger.warn e.message
      end
    end

  end

  def cost
    purchase_cost
  end

  #-----------------------------------------------------------------------------
  #
  # Protected Methods
  #
  #-----------------------------------------------------------------------------
  protected

  # Set the description field
  def set_description
    self.description = "#{self.manufacturer.code} #{self.manufacturer_model}" unless self.manufacturer.nil?
  end

  # Set resonable defaults for a new service vehicle
  def set_defaults
    super
    self.seating_capacity ||= 2
    self.vehicle_length ||= 0
    self.gross_vehicle_weight ||= 0
    self.asset_type ||= AssetType.find_by_class_name(self.name)
  end

end
