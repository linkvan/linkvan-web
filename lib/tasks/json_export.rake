require 'rake'

namespace :json do

  # Usage Example:
  #    rake json:export[./db/active_facilities.json]
  desc "export active facilities to a JSON file"
  task :export, [:jsonfile] => [:environment] do |t, args|
    facilities_hash = {
      v1: { facilities: Facility.is_verified.as_json }
    }
    File.open(args[:jsonfile], "w") do |f|
      f.write JSON.pretty_generate( facilities_hash )
    end
  end #/export

end #/json
