class ChangeFacilitySuitability < ActiveRecord::Migration
  def up
    Facility do |f|
      if f.suitability == "Children"
        f.suitability = "children"
      end
    end
  end

  def down
    Facility do |f|
      if f.suitability == "children"
        f.suitability = "Children"
      end
    end
  end
end
