class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name, :null => false
      t.string :unit, :null => false
      t.text :description
      t.text :comments
      t.string :asset_id, :null => false
      t.integer :facility_type, :null => false
      t.integer :alert_amount, :null => false
      t.decimal :unit_price, :precision => 22, :scale => 2
      t.integer :department_id, :null => false
      t.integer :category_id, :null => false

      t.timestamps
    end
  end
end
