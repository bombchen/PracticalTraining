class CreateStockings < ActiveRecord::Migration
  def change
    create_table :stockings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.text :comments
      t.integer :owner_id
      t.boolean :finished

      t.timestamps
    end
  end
end
