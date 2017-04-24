class ChangeAnalyticFacilityType < ActiveRecord::Migration
  def up
    change_column :analytics, :facility, :decimal
  end

  def down
    change_column :analytics, :facility, :string
  end
end
