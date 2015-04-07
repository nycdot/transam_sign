#------------------------------------------------------------------------------
#
# Sign Standard Type Lookup Table
#
# Identifies the type of sigbn standard and maps a sign standard to an asset
# subtype
#
#------------------------------------------------------------------------------
class SignStandardType < ActiveRecord::Base

  # All order types that are available
  scope :active, -> { where(:active => true) }

  # A sub class of asset subtypes
  belongs_to  :asset_subtype

  # maps to sign standards
  has_many  :sign_standards

  def to_s
    name
  end

end
