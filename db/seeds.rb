#encoding: utf-8

# determine if we are using postgres or mysql
is_mysql = (ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'mysql2')
is_sqlite =  (ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'sqlite3')

#------------------------------------------------------------------------------
#
# Lookup Tables
#
# These are the lookup tables for TransAM Sign. The configurations herein should
# conform as much as possible to the MUTCD 2012 Standard Highway Signs
#
# http://mutcd.fhwa/gov/ser-shs_millenium.htm
#
#------------------------------------------------------------------------------

blank_types = [
  {:active => 1, :name => 'Unknown',      :description => 'Unknown blank type.'},
  {:active => 1, :name => 'Aluminium',    :description => 'Aluminium.'},
  {:active => 1, :name => 'Other Metal',  :description => 'Other Metal.'},
  {:active => 1, :name => 'Plywood',      :description => 'Plywood.'}
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
  {:active => 1, :code => "XX", :name => 'Unknown', :description => 'Unknown direction.'},
  {:active => 1, :code => 'N',  :name => 'North', :description => 'North.'},
  {:active => 1, :code => 'NE', :name => 'North East', :description => 'North East.'},
  {:active => 1, :code => 'E',  :name => 'East', :description => 'East.'},
  {:active => 1, :code => 'SE', :name => 'South East', :description => 'South East.'},
  {:active => 1, :code => 'S',  :name => 'South', :description => 'South.'},
  {:active => 1, :code => 'SW', :name => 'South West', :description => 'South West.'},
  {:active => 1, :code => 'W',  :name => 'West', :description => 'West.'},
  {:active => 1, :code => 'NW', :name => 'North West', :description => 'North West.'}
]

support_size_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown post size.'},
  {:active => 1, :name => '2 x 2', :description => 'Two by Two inches.'},
  {:active => 1, :name => '4 x 2', :description => 'Four inches by two inches.'}
]

support_types = [
  {:active => 1, :name => 'Unknown', :description => 'Unknown post type.'},
  {:active => 1, :name => 'Aluminium', :description => 'Aluminuim.'},
  {:active => 1, :name => 'Couplers', :description => 'Couplers.'}
]

service_life_calculation_types = [
  {:active => 1, :name => 'Age Only', :class_name => 'ServiceLifeAgeOnly', :description => 'Calculate the replacement year based on the age of the asset.'},
  {:active => 1, :name => 'Reflectivity Only', :class_name => 'ServiceLifeConditionOnly', :description => 'Calculate the replacement year based on the determined retroreflectivity of the asset.'},
  {:active => 1, :name => 'Age and Reflectivity', :class_name => 'ServiceLifeAgeAndCondition', :description => 'Calculate the replacement year based on the age of the asset or the retroreflectivity value.'}
]

sheeting_types = [
  {:active => 1, :code => 'PNT',  :name => 'Painted',                  :max_service_life => 7,  :description => 'Painted.'},
  {:active => 1, :code => 'PHI',  :name => 'Prismatic High Intensity', :max_service_life => 10, :description => 'Prismatic High Intensity.'},
  {:active => 1, :code => 'DG',   :name => 'Diamond Grade',            :max_service_life => 10, :description => 'Diamond Grade - Fluorescent Yellow.'},
  {:active => 1, :code => 'EG',   :name => 'Engineering Grade',        :max_service_life => 7,  :description => 'Engineer Grade.'}
]

side_types = [
  {:active => 1, :code => 'L',  :name => 'Left',  :description => 'Left.'},
  {:active => 1, :code => 'R',  :name => 'Right', :description => 'Right.'}
]

time_of_day_types = [
  {:active => 1, :name => 'Unknown',:description => 'Unknown.'},
  {:active => 1, :name => 'Day',    :description => 'Day.'},
  {:active => 1, :name => 'Night',  :description => 'Night.'}
]

fuel_types = [
  {:active => 1, :name => 'Biodiesel',                      :code => 'BD', :description => 'Biodiesel.'},
  {:active => 1, :name => 'Bunker Fuel',                    :code => 'BF', :description => 'Bunker Fuel.'},
  {:active => 1, :name => 'Compressed Natural Gas',         :code => 'CN', :description => 'Compressed Natutral Gas.'},
  {:active => 1, :name => 'Diesel Fuel',                    :code => 'DF', :description => 'Diesel Fuel.'},
  {:active => 1, :name => 'Dual Fuel',                      :code => 'DU', :description => 'Dual Fuel.'},
  {:active => 1, :name => 'Electric Battery',               :code => 'EB', :description => 'Electric Battery.'},
  {:active => 1, :name => 'Electric Propulsion',            :code => 'EP', :description => 'Electric Propulsion.'},
  {:active => 1, :name => 'Ethanol',                        :code => 'ET', :description => 'Ethanol.'},
  {:active => 1, :name => 'Gasoline',                       :code => 'GA', :description => 'Gasoline.'},
  {:active => 1, :name => 'Hybrid Diesel',                  :code => 'HD', :description => 'Hybrid Diesel.'},
  {:active => 1, :name => 'Hybrid Gasoline',                :code => 'HG', :description => 'Hybrid Gasoline.'},
  {:active => 1, :name => 'Hydrogen',                       :code => 'HY', :description => 'Hydrogen.'},
  {:active => 1, :name => 'Kerosene',                       :code => 'KE', :description => 'Kerosene.'},
  {:active => 1, :name => 'Liquefied Natural Gas',          :code => 'LN', :description => 'Liquefied Natural Gas.'},
  {:active => 1, :name => 'Liquefied Petroleum Gas',        :code => 'LP', :description => 'Liquefied Petroleum Gas.'},
  {:active => 1, :name => 'Methanol',                       :code => 'MT', :description => 'Methanol.'},
  {:active => 1, :name => 'Other',                          :code => 'OR', :description => 'Other.'}
]
vehicle_features = [
  {:active => 1, :name => 'AVL System',           :code => 'AS', :description => 'Automatic Vehicle Location System.'},
  {:active => 1, :name => 'Video Cameras',        :code => 'VC', :description => 'Video Cameras.'},
  {:active => 1, :name => 'Radio Equipped',       :code => 'RE', :description => 'Radio Equipped.'},
  {:active => 1, :name => 'WIFI',                 :code => 'WI', :description => 'WIFI.'}
]

#------------------------------------------------------------------------------
#
# Sign Taxonomy
#
# This is the deafult taxonomy for TransAM Sign.  Note that Sign can be added
# to other configs eg DOT + Sign, Transit + Sign, etc., so the taxonomy for sign
# is added to the existing taxonomy and does not replace it.
#
#------------------------------------------------------------------------------

asset_types = [
  {:active => 1, :name => 'Sign',             :description => 'Sign',                 :class_name => 'Sign',            :map_icon_name => "redDotIcon",    :display_icon_name => "fa fa-warning"},
  {:active => 1, :name => 'Support',          :description => 'Support Structrure',   :class_name => 'Support',         :map_icon_name => "greenDotIcon",  :display_icon_name => "fa fa-warning"}
  {:active => 1, :name => 'Service Vehicle',  :description => 'Service Vehicle',      :class_name => 'ServiceVehicle',  :map_icon_name => "blueDotIcon",   :display_icon_name => "fa fa-truck"}
]

asset_subtypes = [
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'redDotIcon',     :name => 'Regulatory Sign', :description => 'Regulatory Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'orangeDotIcon',  :name => 'Warning Sign', :description => 'Warning Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'greenDotIcon',   :name => 'Guide Sign', :description => 'Guide Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'cyanDotIcon',    :name => 'School Sign', :description => 'School Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'blueDotIcon',    :name => 'Parking Sign', :description => 'Parking Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'pinkDotIcon',    :name => 'Bus Sign', :description => 'Bus Sign'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Sign', :icon => 'purpleDotIcon',  :name => 'Special', :description => 'Special Sign'},

  {:active => 1, :belongs_to => 'asset_type',  :type => 'Support', :name => 'Single Post', :description => 'Single Post'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Support', :name => 'Double Post', :description => 'Double Post'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Support', :name => 'Gantry', :description => 'Gantry'},

  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Van', :description => 'Van'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Utility Truck', :description => 'Utility Truck'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Pickup Truck',   :description => 'Pickup Truck'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Bucket Truck',   :description => 'Bucket Truck'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Tower Truck',    :description => 'Tower Truck'},
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Rack Truck',    :description => 'Rack Truck',
  {:active => 1, :belongs_to => 'asset_type',  :type => 'Service Vehicle', :icon => 'yellowDotIcon', :name => 'Other Service Vehicle',    :description => 'Other Service Vehicle'

]

puts "======= Processing TransAM Sign Lookup Tables  ======="

lookup_tables = %w{ blank_types color_types direction_types support_size_types support_types service_life_calculation_types sheeting_types side_types time_of_day_types fuel_types vehicle_features }

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

puts "======= Processing TransAM Sign Taxonomy  ======="

table_name = 'asset_types'
puts "  Loading #{table_name}"
data = eval(table_name)
klass = table_name.classify.constantize
data.each do |row|
  x = klass.new(row)
  x.save!
end

table_name = 'asset_subtypes'
puts "  Loading #{table_name}"
data = eval(table_name)
data.each do |row|
  x = AssetSubtype.new(row.except(:belongs_to, :type))
  x.asset_type = AssetType.where(:name => row[:type]).first
  x.save!
end
