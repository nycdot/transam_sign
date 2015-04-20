class ColorType < ActiveRecord::Base

  default_scope { order(:name) }

  scope :active, -> { where(active: true) }

  def to_s
    name
  end


end
