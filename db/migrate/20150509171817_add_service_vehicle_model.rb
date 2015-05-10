class AddServiceVehicleModel < ActiveRecord::Migration
  def change

    # Fuel Type Lookup
    create_table :fuel_types do |t|
      t.string  :name,        :limit => 64,  :null => false
      t.string  :code,        :limit => 2,   :null => false
      t.string  :description, :limit => 254, :null => false
      t.boolean :active,                     :null => false
    end

    # Vehicle Features
    create_table :vehicle_features do |t|
      t.string  :name,        :limit => 64,  :null => false
      t.string  :code,        :limit => 3,   :null => false
      t.string  :description, :limit => 254, :null => false
      t.boolean :active,                     :null => false
    end

    # Map Table for HABTM relationship between vehicles and vehicle features
    create_join_table :assets, :vehicle_features do |t|
      t.index [:asset_id, :vehicle_feature_id], :name => :assets_vehicle_features_idx1
    end

    # Updates to the asset tables
    add_column :assets, :fuel_type_id,                :integer
    add_column :assets, :title_owner_organization_id, :integer
    add_column :assets, :vehicle_length,              :integer
    add_column :assets, :gross_vehicle_weight,        :integer
    add_column :assets, :seating_capacity,            :integer
    add_column :assets, :license_plate,               :string,  :limit => 12
    add_column :assets, :title_number,                :string,  :limit => 32
    add_column :assets, :reported_mileage,            :integer
    add_column :assets, :reported_mileage_date,       :date

    # Add the mileage update event to the asset events tables
    add_column :asset_events, :current_mileage,       :integer

  end
end
