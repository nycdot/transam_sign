class SupportType < ActiveRecord::Base

  default_scope { order(:name) }

  scope :active, -> { where(active: true) }
  scope :fixed, -> { where(active: true, fixed_support: true) }
  scope :not_fixed, -> { where(active: true, fixed_support: false) }

  def to_s
    name
  end

end
