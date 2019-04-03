require 'rails_helper'

RSpec.describe Facility do
    describe '#contains_service' do
        fixtures :facilities

        context 'parameters:' do

            context 'opened facilities' do
                let(:open_all_day) { facilities(:open_all_day) }
                ['Near', 'Name'].each { |prox|
                    context "prox='#{prox}'," do
                        it "should return a facility if open='Yes'" do
                            service_string = open_all_day.services
                            ulat = open_all_day.lat
                            ulong = open_all_day.long
                            searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                            expect(searched_facility).to include(open_all_day)
                        end
                        it "should not return a facility if open='No'" do
                            service_string = open_all_day.services
                            ulat = open_all_day.lat
                            ulong = open_all_day.long
                            searched_facility = Facility.contains_service(service_string, prox, "No", ulat, ulong)
                            expect(searched_facility).to be_empty
                        end
                    end #/prox
                } #/[prox]
            end  #/ opened facilities
            context 'closed facilities' do
                let(:close_all_day) { facilities(:close_all_day) }
                ['Near', 'Name'].each { |prox|
                    context "prox='#{prox}'," do
                        it "should return a facility if open='Yes'" do
                            service_string = close_all_day.services
                            ulat = close_all_day.lat
                            ulong = close_all_day.long
                            searched_facility = Facility.contains_service(service_string, prox, "Yes", ulat, ulong)
                            expect(searched_facility).to be_empty
                        end
                        it "should not return a facility if open='No'" do
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
                    expected_order = [open_all_day, open_all_day_nearby]
                    service_string = open_all_day.services
                    ulat = open_all_day_nearby.lat
                    ulong = open_all_day_nearby.long
                    searched_facility = Facility.contains_service(service_string, 'Name', "Yes", ulat, ulong)
                    expect(searched_facility).to eq(expected_order)
                end
                it 'should sort by proximity' do
                    expected_order = [open_all_day_nearby, open_all_day]  #/ using open_all_day_nearby as base to make sure it's sorting.
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
