class AddFieldsToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :fid, :integer
    add_column :statuses, :changetype, :string
  end
end
