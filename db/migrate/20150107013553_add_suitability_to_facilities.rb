class AddSuitabilityToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :suitability, :string
  end
end
