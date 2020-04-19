class AddOverdoseNoteToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :overdose_note, :text
  end
end
