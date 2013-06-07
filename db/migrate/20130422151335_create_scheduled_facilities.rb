class CreateScheduledFacilities < ActiveRecord::Migration
  def change
    create_table :scheduled_facilities do |t|
      t.integer :schedule_id
      t.string :facility_id

      t.timestamps
    end
  end
end
