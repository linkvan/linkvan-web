class AddTypeToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :notice_type, :string
  end
end
