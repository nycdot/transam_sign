class SheetingType < ActiveRecord::Base

  default_scope { order(:code) }

  scope :active, -> { where(active: true) }

  def to_s
    name
  end

end
