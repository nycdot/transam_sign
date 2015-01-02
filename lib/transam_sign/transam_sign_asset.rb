module TransamSignAsset
  #------------------------------------------------------------------------------
  #
  # TransamSignAsset
  #
  # Extend Asset to handle transit behaviors such as tracking how the asset was
  # purchased, etc.
  #
  #------------------------------------------------------------------------------
  extend ActiveSupport::Concern

  included do


    #------------------------------------------------------------------------------
    # Callbacks
    #------------------------------------------------------------------------------
    after_initialize    :set_defaults

    # ----------------------------------------------------
    # Associations
    # ----------------------------------------------------

    # ----------------------------------------------------
    # Validations
    # ----------------------------------------------------

    #------------------------------------------------------------------------------
    # Lists. These lists are used by derived classes to make up lists of attributes
    # that can be used for operations like full text search etc. Each derived class
    # can add their own fields to the list
    #------------------------------------------------------------------------------

    SEARCHABLE_FIELDS = [
    ]
    CLEANSABLE_FIELDS = [
    ]
    UPDATE_METHODS = [
    ]

    # List of hash parameters specific to this class that are allowed by the controller
    FORM_PARAMS = [
    ]

  end

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------

  module ClassMethods
    def self.allowable_params
      FORM_PARAMS
    end

  end

  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------
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

  def update_methods
    a = []
    a << super
    UPDATE_METHODS.each do |method|
      a << method
    end
    a.flatten
  end

  protected

  def set_defaults

  end
end
