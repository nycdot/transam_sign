class DirectionType < ActiveRecord::Base

  default_scope { order(:code) }

  scope :active, -> { where(active: true) }
  scope :arrow_direction_types, -> { where(code: ['N', 'S', 'E', 'W']) }

  def to_s
    name
  end

end
