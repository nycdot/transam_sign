#encoding: utf-8

# determine if we are using postgres or mysql
is_mysql = (ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'mysql2')
is_sqlite =  (ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'sqlite3')

#------------------------------------------------------------------------------
#
# Lookup Tables
#
# These are the lookup tables for TransAM Spatial
#
#------------------------------------------------------------------------------

puts "======= Processing TransAM Sign Lookup Tables  ======="


blank_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown blank type.'},
  {:active => 1, :name => 'Aluminium', :description => 'Aluminiu m.'},
  {:active => 1, :name => 'Other Metal', :description => 'Other Metal.'},
  {:active => 1, :name => 'Plywood', :description => 'Plywood.'}
]

color_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown color.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Black',  :description => 'Black.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Blue',   :description => 'Blue.', :legend => 0, :background => 1},
  {:active => 1, :name => 'Brown',  :description => 'Brown.', :legend => 0, :background => 1},
  {:active => 1, :name => 'Green',  :description => 'Green.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Orange', :description => 'Orange.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Red',    :description => 'Red.', :legend => 1, :background => 1},
  {:active => 1, :name => 'White',  :description => 'White.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Yellow', :description => 'Yellow.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Purple', :description => 'Purple.', :legend => 0, :background => 1},
  {:active => 1, :name => 'Flourescent Yellow', :description => 'Flourescent Yellow.', :legend => 1, :background => 1},
  {:active => 1, :name => 'Flourescent Pink', :description => 'Flourescent Pink.', :legend => 1, :background => 1}
]

direction_types = [
  {:active => 1, :code => "U",  :name => 'Unknown', :description => 'Unknown direction.'},
  {:active => 1, :code => 'N',  :name => 'North', :description => 'North.'},
  {:active => 1, :code => 'NE', :name => 'North East', :description => 'North East.'},
  {:active => 1, :code => 'E',  :name => 'East', :description => 'East.'},
  {:active => 1, :code => 'SE', :name => 'South East', :description => 'South East.'},
  {:active => 1, :code => 'S',  :name => 'South', :description => 'South.'},
  {:active => 1, :code => 'SW', :name => 'South West', :description => 'South West.'},
  {:active => 1, :code => 'W',  :name => 'West', :description => 'West.'},
  {:active => 1, :code => 'NW', :name => 'North West', :description => 'North West.'}
]

post_size_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown post size.'},
  {:active => 1, :name => '2 x 2', :description => 'Two by Two inches.'},
  {:active => 1, :name => '4 x 2', :description => 'Four inches by two inches.'}
]

post_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown post type.', :avg_cost => 0},
  {:active => 1, :name => 'Aluminium', :description => 'Aluminuim.', :avg_cost => 500},
  {:active => 1, :name => 'Wood', :description => 'Plywood.', :avg_cost => 250}
]

service_life_calculation_types = [
  {:active => 1, :name => 'Age Only', :class_name => 'ServiceLifeAgeOnly', :description => 'Calculate the replacement year based on the age of the asset.'},
  {:active => 1, :name => 'Reflectivity Only', :class_name => 'ServiceLifeConditionOnly', :description => 'Calculate the replacement year based on the determined retroreflectivity of the asset.'},
  {:active => 1, :name => 'Age and Reflectivity', :class_name => 'ServiceLifeAgeAndCondition', :description => 'Calculate the replacement year based on the age of the asset or the retroreflectivity value.'}
]

sheeting_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown sheeting type.'},
  {:active => 1, :name => 'Prismatic High Intensity', :description => 'Prismatic High Intensity.'},
  {:active => 1, :name => 'Diamond Grade', :description => 'Diamond Grade - Fluorescent Yellow.'},
  {:active => 1, :name => 'Engineering Grade', :description => 'Engineer Grade.'}
]

side_types = [
  {:active => 1, :code => "U",  :name => 'Unknown', :description => 'Unknown side.'},
  {:active => 1, :code => 'L',  :name => 'Left',  :description => 'Left.'},
  {:active => 1, :code => 'R',  :name => 'Right', :description => 'Right.'}
]


lookup_tables = %w{ blank_types color_types direction_types post_size_types post_types service_life_calculation_types sheeting_types side_types }

lookup_tables.each do |table_name|
  puts "  Loading #{table_name}"
  if is_mysql
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name};")
  elsif is_sqlite
    ActiveRecord::Base.connection.execute("DELETE FROM #{table_name};")
  else
    ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY;")
  end
  data = eval(table_name)
  klass = table_name.classify.constantize
  data.each do |row|
    x = klass.new(row)
    x.save!
  end
end
