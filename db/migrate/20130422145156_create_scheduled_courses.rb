class CreateScheduledCourses < ActiveRecord::Migration
  def change
    create_table :scheduled_courses do |t|
      t.integer :teacher_id, :null => false
      t.date :begin_date, :null => false
      t.date :end_date, :null => false
      t.integer :wday, :null => false
      t.string :cls, :null => false
      t.string :title, :null => false
      t.integer :field_id
      t.integer :idx, :null => false

      t.timestamps
    end
  end
end
