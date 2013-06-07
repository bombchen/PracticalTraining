class CreateFieldStatuses < ActiveRecord::Migration
  def change
    create_table :field_statuses do |t|
      t.string :name
      t.boolean :available, :null => false, :default => false
      t.boolean :systematic, :null => false, :default => false

      t.timestamps
    end
  end
end
