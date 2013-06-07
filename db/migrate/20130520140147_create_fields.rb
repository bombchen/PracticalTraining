class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.string :description
      t.integer :status_id

      t.timestamps
    end
  end
end
