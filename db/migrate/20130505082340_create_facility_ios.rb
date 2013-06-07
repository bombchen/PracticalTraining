class CreateFacilityIos < ActiveRecord::Migration
  def change
    create_table :facility_ios do |t|
      t.integer :facility_id
      t.integer :amount
      t.integer :owner_id
      t.integer :reason_id
      t.date :date
      t.text :comments

      t.timestamps
    end
  end
end
