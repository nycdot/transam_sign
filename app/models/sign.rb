#------------------------------------------------------------------------------
#
# Sign
#
# Sign asset class. Models a sign asset in the system
#
#------------------------------------------------------------------------------
class Sign < Asset

  # ----------------------------------------------------
  # Behaviors
  # ----------------------------------------------------
  # Inherited from Asset

  # ----------------------------------------------------
  # Callbacks
  # ----------------------------------------------------
  after_initialize :set_defaults

  # ----------------------------------------------------
  # Associations
  # ----------------------------------------------------
  # Every sign has a sign_standard (SMO)
  belongs_to  :sign_standard

  # Type of sheeting used on the face of the sign
  belongs_to  :sign_sheeting_type

  # Type of backing material
  belongs_to  :sign_blank_type

  # legend color
  belongs_to  :sign_legend_color_type, :class_name => 'ColorType', :foreign_key => :sign_legend_color_type_id

  # background color
  belongs_to  :sign_background_color_type, :class_name => 'ColorType', :foreign_key => :sign_background_color_type_id

  # Type of support
  belongs_to  :support_type

  # Size of the post in inches
  belongs_to  :support_size_type

  # Direction of travel with respect to mileposts, markers, etc.
  belongs_to  :travel_direction_type,  :class_name => "DirectionType", :foreign_key => :travel_direction_type_id

  # Compass direction for the face of the sign
  belongs_to  :facing_direction_type,  :class_name => "DirectionType", :foreign_key => :facing_direction_type_id

  # Side of the road for the sign w/r/t the direction of travel
  belongs_to  :side_of_road_type,      :class_name => "SideType",      :foreign_key => :side_of_road_type_id

  # ----------------------------------------------------
  # Validations
  # ----------------------------------------------------

  validates :sign_standard,               :presence => true
  validates :sign_sheeting_type,          :presence => true
  validates :sign_blank_type,             :presence => true
  #validates :sign_legend_color_type,      :presence => true
  #validates :sign_background_color_type,  :presence => true
  #validates :support_type,                :presence => true
  #validates :support_size_type,           :presence => true
  validates :travel_direction_type,       :presence => true
  validates :facing_direction_type,       :presence => true
  validates :side_of_road_type,           :presence => true

  validates :distance_from_intersection,  :presence => true, :numericality => {:only_integer => :true, :greater_than_or_equal_to => 0}
  validates :distance_from_curb,          :presence => true, :numericality => {:only_integer => :true, :greater_than_or_equal_to => 0}

  validates :street_name,                 :presence => true

  #------------------------------------------------------------------------------
  # Lists. These lists are used by derived classes to make up lists of attributes
  # that can be used for operations like full text search etc. Each derived class
  # can add their own fields to the list
  #------------------------------------------------------------------------------

  SEARCHABLE_FIELDS = [
    :sign_standard,
    :sign_sheeting_type,
    :sign_blank_type,
    :street_name
  ]
  CLEANSABLE_FIELDS = [

  ]

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #-----------------------------------------------------------------------------
  def self.allowable_params
    FORM_PARAMS
  end

  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------

  # Install date is modeled as the in-service-date for the sign
  def install_date
    in_service_date
  end

  # Creates a duplicate that has all asset-specific attributes nilled
  def copy(cleanse = true)
    a = dup
    a.cleanse if cleanse
    a
  end

  # Override the name property
  def name
    description
  end

  # override the cost property
  def cost
    purchase_cost
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

  #------------------------------------------------------------------------------
  #
  # Protected Methods
  #
  #------------------------------------------------------------------------------
  protected

  # Set resonable defaults for a new generic sign
  def set_defaults
    super
  end

end
