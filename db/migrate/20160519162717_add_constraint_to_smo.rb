class AddConstraintToSmo < ActiveRecord::Migration
  def change

    add_index :sign_standards, [:smo_code], :unique => true

  end
end
