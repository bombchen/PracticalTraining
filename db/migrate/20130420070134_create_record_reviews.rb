class CreateRecordReviews < ActiveRecord::Migration
  def change
    create_table :record_reviews do |t|
      t.integer :record_id
      t.integer :status, :null => false, :default => 0
      t.text :comments

      t.timestamps
    end
  end
end
