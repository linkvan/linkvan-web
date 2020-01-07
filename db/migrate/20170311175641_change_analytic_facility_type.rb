class ChangeAnalyticFacilityType < ActiveRecord::Migration
  def up
    change_column :analytics, :facility, 'decimal USING CAST(facility AS decimal)'
  end

  def down
    change_column :analytics, :facility, :string
  end
end
