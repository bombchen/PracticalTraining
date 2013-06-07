class CreateStockingDetails < ActiveRecord::Migration
  def change
    create_table :stocking_details do |t|
      t.integer :stocking_id
      t.integer :facility_id
      t.integer :old_amount
      t.integer :new_amount

      t.timestamps
    end
  end
end
