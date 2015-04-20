class BlankType < ActiveRecord::Base

  scope :active, -> { where(active: true) }

  default_scope { order(:name) }

  def to_s
    name
  end

end
