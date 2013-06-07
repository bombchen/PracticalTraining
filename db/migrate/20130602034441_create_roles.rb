class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :friendly_name
      t.text :description

      t.timestamps
    end
  end
end
