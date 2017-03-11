class ChangeListedOptionsName < ActiveRecord::Migration
  def up
    rename_table 'listedOptions', 'listed_options'
  end

  def down
    rename_table 'listed_options', 'listedOptions'
  end
end
