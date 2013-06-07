class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.date :date, :null => false
      t.integer :idx, :null => false
      t.string :title, :null => false
      t.integer :teacher_id, :null => false
      t.string :cls, :null => false
      t.integer :field_id, :null => false

      t.timestamps
    end
  end
end
