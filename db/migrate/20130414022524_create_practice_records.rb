class CreatePracticeRecords < ActiveRecord::Migration
  def change
    create_table :practice_records do |t|
      t.integer :course_id
      t.text :record

      t.timestamps
    end
  end
end
