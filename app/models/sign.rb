#------------------------------------------------------------------------------
#
# Sign
#
# Abstract class that adds sign attributes to the base Asset class. All concrete
# sign types should be drived from this base class
#
#------------------------------------------------------------------------------
class Sign < Asset

  # Callbacks
  after_initialize :set_defaults

  # ----------------------------------------------------
  # Work Orders
  # ----------------------------------------------------
  # Signs can be associated with a work orders
  #belongs_to  :order

  validates_numericality_of :distance_from_intersection,        :only_integer => :true,   :greater_than_or_equal_to => 0
  validates                 :direction_from_intersection,       :presence => :true

  # ----------------------------------------------------
  # Sign Physical Characteristics
  # ----------------------------------------------------
  # Type of sheeting used on the face of the sign
  belongs_to :sign_sheeting_type
  # Type of backing material
  belongs_to :sign_blank_type
  # legend color
  belongs_to :sign_legend_color_type, :class_name => 'ColorType', :foreign_key => :sign_legend_color_type_id
  # background color
  belongs_to :sign_background_color_type, :class_name => 'ColorType', :foreign_key => :sign_background_color_type_id

  # Validations for sign physical characteristics
  validates :sign_sheeting_type_id,         :presence => true
  validates :sign_blank_type_id,            :presence => true
  validates :sign_legend_color_type_id,     :presence => true
  validates :sign_background_color_type_id, :presence => true
  validates :sign_message,                  :presence => true
  # ----------------------------------------------------

  # ----------------------------------------------------
  # Sign Post Characteristics
  # ----------------------------------------------------
  # Type of post
  belongs_to :post_type
  # Size of the post in inches
  belongs_to :post_size_type

  # Validations for sign physical characteristics
  validates :post_type,       :presence => true
  validates :post_size_type,  :presence => true
  validates :post_length,     :presence => true
  validates :post_count,      :presence => true
  validates :post_sign_count, :presence => true
  # ----------------------------------------------------

  # ----------------------------------------------------
  # Location Characteristics
  # ----------------------------------------------------
  # Direction of travel with respect to mileposts, markers, etc.
  belongs_to :travel_direction_type, :class_name => "DirectionType", :foreign_key => "travel_direction_type_id"
  # Compass direction for the face of the sign
  belongs_to :facing_direction_type, :class_name => "DirectionType", :foreign_key => "facing_direction_type_id"
  # Side of the road for the sign w/r/t the direction of travel
  belongs_to :side_of_road_type, :class_name => "SideType", :foreign_key => "side_of_road_type_id"

  # Validations for location characteristics
  validates :travel_direction_type,   :presence => true
  validates :facing_direction_type,   :presence => true
  validates :side_of_road_type,       :presence => true
  validates :lateral_offset,          :presence => true
  validates :street_name,             :presence => true
  # ----------------------------------------------------

  # ----------------------------------------------------
  # Other Characteristics
  # ----------------------------------------------------
  # Company who performed the install
  belongs_to :installer, :class_name => "Organization", :foreign_key => "installer_id"

  #------------------------------------------------------------------------------
  # Lists. These lists are used by derived classes to make up lists of attributes
  # that can be used for operations like full text search etc. Each derived class
  # can add their own fields to the list
  #------------------------------------------------------------------------------

  SEARCHABLE_FIELDS = [
    'street_name',
    'sign_message',
    'sign_comments',
    'post_comments'
  ]
  CLEANSABLE_FIELDS = [

  ]

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------

  def self.allowable_params
    FORM_PARAMS
  end


  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------

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
    self.sign_message ||= asset_subtype.description unless asset_subtype.nil?
    self.post_length ||= 10
    self.post_count ||= 1
    self.post_sign_count ||= 1
    self.lateral_offset ||= 5
    self.install_date ||= Date.today
  end

end
