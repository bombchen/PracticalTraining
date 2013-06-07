class CreateFacilityReturns < ActiveRecord::Migration
  def change
    create_table :facility_returns do |t|
      t.integer :application_id
      t.text :comments
      t.integer :borrowed_amount
      t.datetime :borrowed_time
      t.integer :returned_amount
      t.datetime :returned_time
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
