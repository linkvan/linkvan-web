puts 'initializing...'
Facility.all.each do |f|
	f.startsmon_at2 = "2001-01-01 01:23:45"
	f.startstues_at2 = "2001-01-01 01:23:45"
	f.startswed_at2 = "2001-01-01 01:23:45"
	f.startsthurs_at2 = "2001-01-01 01:23:45"
	f.startsfri_at2 = "2001-01-01 14:00:00"
	f.startssat_at2 = "2001-01-01 01:23:45"
	f.startssun_at2 = "2001-01-01 01:23:45"
		
	puts 'updated starts'

	f.endsmon_at2 = "2001-01-01 01:23:45"
	f.endstues_at2 = "2001-01-01 01:23:45"
	f.endswed_at2 = "2001-01-01 01:23:45"
	f.endsthurs_at2 = "2001-01-01 01:23:45"
	f.endsfri_at2 = "2001-01-01 14:20:00"
	f.endssat_at2 = "2001-01-01 01:23:45"
	f.endssun_at2 = "2001-01-01 01:23:45"

	puts 'updated ends'

	f.open_all_day_mon = false
	f.open_all_day_tues = false
	f.open_all_day_wed = true
	f.open_all_day_thurs = false
	f.open_all_day_fri = false
	f.open_all_day_sat = false
	f.open_all_day_sun = false

	puts 'updated open_all_day'

	f.closed_all_day_mon = false
	f.closed_all_day_tues = false
	f.closed_all_day_wed = false
	f.closed_all_day_thurs = false
	f.closed_all_day_fri = false
	f.closed_all_day_sat = false
	f.closed_all_day_sun = true

	puts 'updated closed_all_day'
	f.save
	puts 'saved'
end

puts 'closing'