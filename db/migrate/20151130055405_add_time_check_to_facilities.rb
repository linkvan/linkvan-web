class AddTimeCheckToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :second_time, :boolean, :default => false
  end
end
