class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name, null:false
      t.text :description

      t.timestamps null: false
    end
  end
end
