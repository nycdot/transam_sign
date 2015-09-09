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

  end

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------

  module ClassMethods
    def self.allowable_params
      []
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
    [].each do |field|
      a << field
    end
    a.flatten
  end

  def cleansable_fields
    a = []
    a << super
    [].each do |field|
      a << field
    end
    a.flatten
  end

  def update_methods
    a = []
    a << super
    [].each do |method|
      a << method
    end
    a.flatten
  end

  protected

  def set_defaults
    super
  end
end
