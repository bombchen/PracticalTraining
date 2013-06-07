class CreateCourseReviews < ActiveRecord::Migration
  def change
    create_table :course_reviews do |t|
      t.integer :course_id
      t.integer :status, :default => 0
      t.text :comments

      t.timestamps
    end
  end
end
