class AddVerifedToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :verified, :boolean, default: false
  end
end
