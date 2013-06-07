class CreateFacilityReasons < ActiveRecord::Migration
  def change
    create_table :facility_reasons do |t|
      t.string :reason
      t.boolean :if_add, :null => false, :default => false
      t.boolean :systematic, :null => false, :default => false

      t.timestamps
    end
  end
end
