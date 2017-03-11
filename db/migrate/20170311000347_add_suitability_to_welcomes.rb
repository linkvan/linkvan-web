class AddSuitabilityToWelcomes < ActiveRecord::Migration
  def change
    change_column :facilities, :welcomes, :string
    Facility.find_each do |f|
      f.welcomes = f.welcomes.concat(" " + f.suitability)
      f.save
    end
  end
end
