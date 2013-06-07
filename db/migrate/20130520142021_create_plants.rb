class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.text :description
      t.integer :status_id

      t.timestamps
    end
  end
end
