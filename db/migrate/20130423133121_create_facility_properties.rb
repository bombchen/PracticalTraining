class CreateFacilityProperties < ActiveRecord::Migration
  def change
    create_table :facility_properties do |t|
      t.integer :facility_id
      t.string :property_name
      t.string :property_value

      t.timestamps
    end
  end
end
