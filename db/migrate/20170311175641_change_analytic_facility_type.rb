class ChangeAnalyticFacilityType < ActiveRecord::Migration
  def up
    change_column :analytics, :facility, 'decimal USING CAST(facility AS decimal)'
    # change_column :analytics, :facility, :decimal
  end

  def down
    change_column :analytics, :facility, :string
    # change_column :analytics, :facility, :string
  end
end
