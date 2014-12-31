class RemoveHoursFromFacilities < ActiveRecord::Migration
  def change
  	remove_column :facilities, :hours, :string
  end
end
