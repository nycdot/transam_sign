class ColorType < ActiveRecord::Base

  # default scope
  default_scope where(:active => true)
  # named scopes
  scope :legend_colors, where(:legend => true)
  scope :background_colors, where(:background => true)

end
