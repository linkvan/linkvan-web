class DeleteSuitabilityFromFacility < ActiveRecord::Migration
  def up
    remove_column :facilities, :suitability
  end

  def down
    add_column :facilities, :suitability, :string
  end
end
