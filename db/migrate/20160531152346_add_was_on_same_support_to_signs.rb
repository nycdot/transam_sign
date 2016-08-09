class AddWasOnSameSupportToSigns < ActiveRecord::Migration
  def change
    add_column :assets, :was_on_same_support, :boolean
  end
end
