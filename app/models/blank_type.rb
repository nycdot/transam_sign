class BlankType < ActiveRecord::Base

  scope :active, -> { where(active: true) }

  def to_s
    name
  end

end
