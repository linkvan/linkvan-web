class ChangeAllSuitabilityToLowercase < ActiveRecord::Migration
  def change
    change_column :facilities, :suitability, :string
    Facility.find_each do |f|
      case f.suitability
      when "Children Youth"
        f.suitability = "children youth"
      when "Children Youth Adults"
        f.suitability = "children youth adults"
      when "Children Youth Adults Seniors"
        f.suitability = "children youth adults seniors"
      else
      end
    end
  end
end
