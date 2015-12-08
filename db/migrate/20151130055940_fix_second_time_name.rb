class FixSecondTimeName < ActiveRecord::Migration
  def change
  	rename_column :facilities, :second_time, :second_time_mon
  end
end
