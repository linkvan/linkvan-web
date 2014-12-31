class AddMonToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :startsmon_at, :datetime
    add_column :facilities, :endsmon_at, :datetime
  end
end
