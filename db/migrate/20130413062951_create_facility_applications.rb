class CreateFacilityApplications < ActiveRecord::Migration
  def change
    create_table :facility_applications do |t|
      t.integer :course_id
      t.integer :facility_id
      t.integer :applied, :null => false, :default => 0

      t.timestamps
    end
  end
end
