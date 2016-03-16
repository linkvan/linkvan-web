class RemoveUptodateFromStatuses < ActiveRecord::Migration
  def change
    remove_column :statuses, :uptodate, :boolean
  end
end
