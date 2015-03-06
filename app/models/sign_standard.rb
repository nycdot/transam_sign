#------------------------------------------------------------------------------
#
# SignStandard
#
# SignStandard represents a MUTCD standard sign configuration that is used by
# signs. Each SMO has the following characteristic:
#
#   object_key        --  TransAM identifier
#   smo_code          --  the SMO code eg R-116, SI-134G, etc.
#   size_description  --  A description of the size of the sign eg, "24 x 36". The
#                         size description is normally in inches
#   sign_description  --  A description of the sign text
#   external_id       --  A link to an external system
#   superseded_by_id  --  a foreign key of a SMO that has superseded the current
#                         SMO
#   superseded_date   --  the date that the SMO was superseded
#   voided_on_date    --  the date that the SMO was voided, nil if the SMO is still
#                         active
#
#------------------------------------------------------------------------------
class SignStandard < ActiveRecord::Base

  #-----------------------------------------------------------------------------
  # Behaviors
  #-----------------------------------------------------------------------------
  include TransamObjectKey

  #-----------------------------------------------------------------------------
  # Callbacks
  #-----------------------------------------------------------------------------
  after_initialize  :set_defaults

  #-----------------------------------------------------------------------------
  # Associations
  #-----------------------------------------------------------------------------
  # Every SignStandard can be implemented by 0 or more signs
  has_many    :signs, :class_name => 'Sign', :foreign_key => :asset_id

  # A sign standard can be superceded
  belongs_to  :superseded_by,  :class_name => 'SignStandard',  :foreign_key => :superseded_by_id

  # A sign standard is always associated with an asset subtype
  belongs_to  :asset_subtype

  # Has 0 or more comments. Using a polymorphic association, These will be removed if the sign standard is removed
  has_many    :comments,    :as => :commentable,  :dependent => :destroy

  # ----------------------------------------------------
  # Transient Properties
  # ----------------------------------------------------
  attr_accessor :new_comment

  # ----------------------------------------------------
  # Validations
  # ----------------------------------------------------
  validates   :smo_code,            :presence => true
  validates   :size_description,    :presence => true
  validates   :sign_description,    :presence => true
  validates   :asset_subtype,       :presence => true

  #------------------------------------------------------------------------------
  # Lists. These lists are used by derived classes to make up lists of attributes
  # that can be used for operations like full text search etc. Each derived class
  # can add their own fields to the list
  #------------------------------------------------------------------------------

  FORM_PARAMS = [
    :smo_code,
    :asset_subtype_id,
    :size_description,
    :sign_description,
    :superseded_by_id,
    :voided_on_date,
    :new_comment
  ]

  SEARCHABLE_FIELDS = [
    :smo_code,
    :asset_subtype,
    :size_text,
    :sign_text
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

  # Returns true if the SMO has been superseded (deprecated)
  def deprecated?
    superseded_by.present?
  end

  # Returns true if the sign standard can be deleted
  def deleteable?
    if smo_code == 'SPECIAL'
      # Can't delete the special code
      false
   elsif signs.present?
     # Can't delete if there are assets using the code
     false
   else
     true
   end
  end

  def legend
    sign_description
  end

  # Override default to_s
  def to_s
    name
  end

  # Provide a SMO description
  def description
    "#{smo_code} #{size_description} #{sign_description}"
  end

  # Override the name property
  def name
    description
  end

  def searchable_fields
    a = []
    a << super
    SEARCHABLE_FIELDS.each do |field|
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
  end

end
