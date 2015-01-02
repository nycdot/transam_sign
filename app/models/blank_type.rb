class BlankType < ActiveRecord::Base

  # default scope
  default_scope where(:active => true)

end
