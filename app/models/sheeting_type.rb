class SheetingType < ActiveRecord::Base

  # default scope
  default_scope { where(:active => true) }

  def to_s
    name
  end
  
end
