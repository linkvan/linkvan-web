class CreateAnaylitics < ActiveRecord::Migration
  def change
    create_table :anaylitics do |t|
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
