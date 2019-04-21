require 'rails_helper'
# require 'support/time_helpers'

def fields_data
    ret = {
        name: 'ABC',
        services: 'Technology',
        id: 1,
        verified: true,
        lat: 49.2792033,
        long: -123.09930370000001
    }
    weekdays_hash.each do |wday, value|
        ret.merge!({
            "closed_all_day_#{wday}" => false,
            "second_time_#{wday}" => false,
            "open_all_day_#{wday}" => false,
            "starts#{wday}_at" => '2000-01-01 09:00:00',  #min, hour
            "ends#{wday}_at" => '2000-01-01 13:00:00',    #min, hour
            "starts#{wday}_at2" => '2000-01-01 14:00:00',  #min, hour
            "ends#{wday}_at2" => '2000-01-01 18:00:00'    #min, hour
        })
    end
    return ret
end #/fields_data
def weekdays_hash
    { sun: '2019-03-24', mon: '2019-03-25',
        tues: '2019-03-26', wed: '2019-03-27',
        thurs: '2019-03-28', fri: '2019-03-29', sat: '2019-03-30' }
end #/weekdays_hash
def time_hash
    { midnight: '00:00:00', noon: '12:00:00',
        night: '18:00:00', morning: '09:00:00' }
end #/time_hash
def time_obj(idate, itime_str)
    Time.zone.parse("#{idate} #{time_hash[itime_str]}")
end #/time_obj

RSpec.describe Facility do

    describe '#translate_time' do
        before :each do
            @facility = Facility.create!(fields_data)
        end
        it 'should return ftime formated with date part of cdate' do
            right_translated_time = time_obj(:mon, :morning)
            translated_time = @facility.translate_time(time_obj(:mon, :night), time_obj(:sun, :morning))
            expect(translated_time).to eq(right_translated_time)
        end
    end #/translate_time
    describe '#time_in_range?' do
        before :each do
            @facility = Facility.create!(fields_data)
        end
        it "should return true if ctime is between facility's open and close of that wday" do
            ctime = Time.zone.parse("2015-05-03 10:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(true)
        end
        it "should return false if ctime is not between facility's open and close of that wday (end of day)" do
            ctime = Time.zone.parse("2015-05-03 23:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(false)
        end
        it "should return true if ctime is between facility's 'at2' open and close fields of that wday" do
            ctime = Time.zone.parse("2015-05-03 15:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(true)
        end
        it "should return false if ctime is not between facility's open and close of that wday (mid day)" do
            ctime = Time.zone.parse("2015-05-03 13:10:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(false)
        end
        it "should return false when ctime is equal to facility's close of that wday (mid day)" do
            ctime = Time.zone.parse("2015-05-03 13:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(false)
        end
        it "should return false when ctime is equal to facility's close of that wday (end of day)" do
            ctime = Time.zone.parse("2015-05-03 18:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(false)
        end
        it "should return true if ctime is equal to facility's open that wday (begin of day)" do
            ctime = Time.zone.parse("2015-05-03 09:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(true)
        end
        it "should return true if ctime is equal to facility's open that wday (mid day)" do
            ctime = Time.zone.parse("2015-05-03 14:00:00")
            wday = :mon
            time_is_in_range = @facility.time_in_range?(ctime, wday)
            expect(time_is_in_range).to eq(true)
        end

    end #/time_in_range?
    describe '#is_open?' do
        weekdays_hash.each { |wday, tdate|

            context "on #{wday}," do
                it "should return true if facility is open_all_day_#{wday}" do
                    @facility = Facility.create!(fields_data.merge(open_all_day_mon: true))
                    wday = :mon
                    opened_facility = @facility.is_open?(time_obj(weekdays_hash[wday], :noon))
                    expect(opened_facility).to eq(true)
                end
                it "should return true if ctime is between facility's open and close" do
                    @facility = Facility.create!(fields_data)
                    opened_facility = @facility.is_open?(time_obj(weekdays_hash[wday], :noon))
                    expect(opened_facility).to eq(true)
                end
                it "should return false if facility is close_all_day_#{wday}" do
                    @facility = Facility.create!(fields_data.merge(closed_all_day_mon: true))
                    closed_facility = @facility.is_open?(time_obj(weekdays_hash[wday], :noon))
                    expect(closed_facility).to eq(false)
                end
                it "should return false if ctime is not between facility's open and close" do
                    @facility = Facility.create!(fields_data)
                    closed_facility = @facility.is_open?(time_obj(weekdays_hash[wday], :midnight))
                    expect(closed_facility).to eq(false)
                end
                it "should return true if ctime is equal to facility's open" do
                    @facility = Facility.create!(fields_data)
                    ctime = Time.zone.parse("#{weekdays_hash[wday]} 09:00:00")
                    facility_is_open = @facility.is_open?(ctime)
                    expect(facility_is_open).to eq(true)
                end
            end #/on wday

        }
    end #/is_open?

    describe '#contains_service' do
        fixtures :facilities

        context 'parameters:' do

            it 'should not include not verified facilities' do
                Facility.delete_all
                @facility = Facility.create!(fields_data.merge(verified: false))
                allow(Time).to receive(:now).and_return(time_obj(weekdays_hash[:mon], :morning)+8.hours)
                service_string = @facility.services
                ulat = @facility.lat
                ulong = @facility.long
                searched_facility = Facility.contains_service(service_string, 'Near', "Yes", ulat, ulong)
                expect(searched_facility).to be_empty
            end

            it 'should return empty array if Open is Yes or No' do
                allow(Time).to receive(:now).and_return(time_obj(weekdays_hash[:mon], :morning)+8.hours)
                a_facility = Facility.first
                service_string = a_facility.services
                ulat = a_facility.lat
                ulong = a_facility.long
                searched_facility = Facility.contains_service(service_string, 'Near', "WrongValue", ulat, ulong)
                expect(searched_facility).to be_empty
            end

            context 'opened facilities' do
                let(:open_all_day) { facilities(:open_all_day) }

                ['Near', 'Name'].each { |prox|

                    context "prox='#{prox}'," do
                        context 'open_all_day facilities' do
                            it "should return a facility for open='Yes'" do
                                service_string = open_all_day.services
                                ulat = open_all_day.lat
                                ulong = open_all_day.long
                                searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                                expect(searched_facility).to include(open_all_day)
                            end
                            it "should not return a facility for open='No'" do
                                service_string = open_all_day.services
                                ulat = open_all_day.lat
                                ulong = open_all_day.long
                                searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                                expect(searched_facility).to be_empty
                            end
                        end

                        weekdays_hash.each { |wday, tdate|

                            context "on #{wday}," do
                                before :each do
                                    # @facility = double( 'facility', fields)
                                    Facility.delete_all
                                    @facility = Facility.create!(fields_data)
                                end

                                context "open='Yes'" do
                                    # Facility#contain_services compare facility time fields with '8.hours.ago'
                                    #    I couldn't figure out exactly why, but I'm guessing it's been 
                                    #    doing this because of Timezone (UTC x PST).
                                    it 'should return a facility when current time is equal to the start time' do
                                        ttime = time_obj(tdate, :morning)
                                        allow(Time).to receive(:now).and_return(ttime+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                                        expect(searched_facility.count).to eq(1)
                                        expect(searched_facility).to include(@facility)
                                    end
                                    it 'should return a facility when current time is within open time' do
                                        allow(Time).to receive(:now).and_return(time_obj(tdate, :noon)+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                                        expect(searched_facility).to include(@facility)
                                    end
                                    it 'should not return a facility when current time is equal to close time' do
                                        allow(Time).to receive(:now).and_return(time_obj(tdate, :night)+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                                        expect(searched_facility).to be_empty
                                    end
                                    it 'should not return a facility when current time is outside open time' do
                                        allow(Time).to receive(:now).and_return(time_obj(tdate, :midnight)+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                                        expect(searched_facility).to be_empty
                                    end
                                end #/open=Yes

                                context "open='No', " do
                                    # # Facility#contain_services compare facility time fields with '8.hours.ago'
                                    # #    I couldn't figure out exactly why, but I'm guessing it's been 
                                    # #    doing this because of Timezone (UTC x PST).
                                    # FNL - May be for Openning Soon facilities
                                    # TODO: SHOULD THIS PREVIOUS BEHAVIOUR STILL BE CONSIDERED? SEEMS TO BE A BUG
                                    # it 'should still return a facility when current time is equal to the start time' do
                                    #     ctime = time_obj(tdate, :morning)
                                    #     allow(Time).to receive(:now).and_return(ctime+8.hours)
                                    #     service_string = @facility.services
                                    #     ulat = @facility.lat
                                    #     ulong = @facility.long
                                    #     searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                                    #     expect(searched_facility).to include(@facility)
                                    # end
                                    it 'should not return a facility when current time is within open time' do
                                        allow(Time).to receive(:now).and_return(time_obj(tdate, :noon)+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                                        expect(searched_facility).to be_empty
                                    end
                                    # FNL - May be for Closing Soon facilities
                                    # TODO: SHOULD THIS PREVIOUS BEHAVIOUR STILL BE CONSIDERED? SEEMS TO BE A BUG
                                    # it 'should not return a facility when current time is equal to close time' do
                                    #     allow(Time).to receive(:now).and_return(time_obj(tdate, :night)+8.hours)
                                    #     service_string = @facility.services
                                    #     ulat = @facility.lat
                                    #     ulong = @facility.long
                                    #     searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                                    #     expect(searched_facility).to be_empty
                                    # end
                                    it 'should return a facility when current time is outside open time' do
                                        allow(Time).to receive(:now).and_return(time_obj(tdate, :midnight)+8.hours)
                                        service_string = @facility.services
                                        ulat = @facility.lat
                                        ulong = @facility.long
                                        searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                                        expect(searched_facility).to include(@facility)
                                    end
                                end #/open=No

                           end #/context(wday)
                       }
                    end #/prox
                } #/[prox]
            end  #/ opened facilities

            context 'closed_all_day facilities' do
                let(:close_all_day) { facilities(:close_all_day) }
                ['Near', 'Name'].each { |prox|
                    context "prox='#{prox}'," do
                        it "should return a facility for open='Yes'" do
                            service_string = close_all_day.services
                            ulat = close_all_day.lat
                            ulong = close_all_day.long
                            searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                            expect(searched_facility).to be_empty
                        end
                       it "should not return a facility for open='No'" do
                            service_string = close_all_day.services
                            ulat = close_all_day.lat
                            ulong = close_all_day.long
                            searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                            expect(searched_facility).to include(close_all_day)
                        end
                    end #/prox
                }  #[prox]
            end #/ closed facilities

            context 'sorting results' do
                let(:open_all_day) { facilities(:open_all_day) }
                let(:open_all_day_nearby) { facilities(:open_all_day_nearby) }

                it 'should sort by name' do
                    expected_order = [open_all_day, open_all_day_nearby].sort_by(&:name)
                    service_string = open_all_day.services
                    ulat = open_all_day_nearby.lat
                    ulong = open_all_day_nearby.long
                    searched_facility = Facility.contains_service(service_string, 'Name', "Yes", ulat, ulong)
                    expect(searched_facility).to eq(expected_order)
                end
                it 'should sort by proximity' do
                    expected_order = [open_all_day_nearby, open_all_day] #/ using open_all_day_nearby as base to make sure it's sorting.
                    service_string = open_all_day.services
                    ulat = open_all_day_nearby.lat
                    ulong = open_all_day_nearby.long
                    searched_facility = Facility.contains_service(service_string, 'Near', "Yes", ulat, ulong)
                    expect(searched_facility).to eq(expected_order)
                end
            end #/sorting results

        end #/parameters
    end  #/contains_service

end  #/Facility







