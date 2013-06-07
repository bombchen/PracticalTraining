class CreateFacilityTotals < ActiveRecord::Migration
  def change
    create_table :facility_totals do |t|
      t.integer :facility_id
      t.integer :total, :null => false, :default => 0

      t.timestamps
    end
  end
end
