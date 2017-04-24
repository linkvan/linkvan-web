class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :title
      t.text :content
      t.boolean :active

      t.timestamps null: false
    end
  end
end
