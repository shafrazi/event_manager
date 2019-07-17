require "csv"
require "google/apis/civicinfo_v2"

civicinfo = Google::Apis::CivicinfoV2::CivicInfoService.new
civicinfo.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

puts "EventManager Initilaized!"

class Attendee
  attr_accessor :name, :email, :city
  def initialize(name, email, city)
    @name = name
    @email = email
    @city = city
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end


data = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
data.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  begin
    legislators = civicinfo.representative_info_by_address(address: zipcode, levels: "country", roles: ["legislatorUpperBody", "legislatorLowerBody"])
    legislators = legislators.officials
    legislator_names = []
    legislators.each do |legislator|
      legislator_names << legislator.name
    end
  rescue
    "You can find your representative by visiting www.commoncause.org/take-action/find-elected-officials"
  end
  puts "#{name} #{zipcode} #{legislator_names.join(",") if legislator_names}"
end