require 'rake'

namespace :import do

  # Usage Examples:
  #    - To take db/drinking-fountains.json file:
  #      rake import:water_fountains
  #    - To submit own file
  #      rake import:water_fountains[./db/active_facilities.json]
  #
  desc "import water fountains JSON file as facilities"
  task :water_fountains, [:jsonfile] => [:environment] do |t, args|
    jsonfilename = args[:jsonfile]
    jsonfilename = Rails.root.join('db/drinking-fountains.json') if jsonfilename.blank?
    
    abort "Must provide a file to be processed. Aborting..." if jsonfilename.blank?
    abort "File #{jsonfilename} doens't exist. Aborting..." unless File.exists?(jsonfilename)

    json_file = File.open(jsonfilename)
    water_fountains = JSON.load(json_file)
    
    failed_to_delete = []

    Facility.transaction do
      current_facilities = Facility.water_fountains.to_a
      puts "There are currently #{current_facilities.count} Water Fountain facilities."

      if current_facilities.count.positive?
        print "Deleting previous Water Fountains facilities: "
        current_facilities.each do |facility|
          if facility.destroy
            print "."
          else
            print "E"
            failed_to_delete << facility
          end
        end
        print "\n"
      end

      puts "Failed to delete #{failed_to_delete.count} facilities. IDs: #{failed_to_delete.pluck(:id)}" if failed_to_delete.present?

      puts "Creating new Water Fountain facilities from JSON file"
      count = 0
      total = water_fountains.count

      water_fountains.each do |data|
        count += 1
        fountain_data = data['fields']
        name = fountain_data['name'].sub("\n", " ")

        puts "Processing water fountain with name '#{name}' [#{count}/#{total}]"
        geom_data = fountain_data['geom']
        coordinates = geom_data['coordinates']

        facility_hash = {
          name: name,
          services: 'Water_Fountain',
          welcomes: 'Male Female Transgender Children Youth Adult Senior',
          description: 'Water Fountain',
          address: fountain_data['location'],
          lat: coordinates.second,
          long: coordinates.first,
          verified: true,
          phone: '',
          website: '',
        }

        [:sun, :mon, :tues, :wed, :thurs, :fri, :sat].each do |day|
          # Open All Day
          field_name = "open_all_day_#{day}".to_sym
          facility_hash[field_name] = true

          # Closed All Day
          field_name = "closed_all_day_#{day}".to_sym
          facility_hash[field_name] = false

          # Starts At
          ["starts#{day}_at", "starts#{day}_at2"].each do |field|
            facility_hash[field.to_sym] = Time.current.beginning_of_day
          end

          # Ends At
          ["ends#{day}_at", "ends#{day}_at2"].each do |field|
            facility_hash[field.to_sym] = Time.current.end_of_day
          end

        end

        facility = Facility.new(facility_hash)
        unless facility.save
          puts "\t- Failed to create facility '#{facility.name}'; Valid? #{facility.valid?}; Errors: #{facility.errors.full_messages}"
        end
      end
    end
  end
end
