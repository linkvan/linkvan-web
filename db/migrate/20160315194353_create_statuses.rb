class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :uptodate

      t.timestamps null: false
    end
  end
end
