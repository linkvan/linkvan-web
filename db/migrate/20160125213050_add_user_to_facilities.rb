class AddUserToFacilities < ActiveRecord::Migration
  def change
    add_reference :facilities, :user, index: true
  end
end
