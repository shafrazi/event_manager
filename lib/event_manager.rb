require "csv"
require "google/apis/civicinfo_v2"

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

def legislators_by_zipcode(zipcode)
  civicinfo = Google::Apis::CivicinfoV2::CivicInfoService.new
  civicinfo.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
  begin
    legislators = civicinfo.representative_info_by_address(address: zipcode, levels: "country", roles: ["legislatorUpperBody", "legislatorLowerBody"])
    legislators = legislators.officials
    legislator_names = []
    legislators.each do |legislator|
      legislator_names << legislator.name
    end
    legislator_names.join(",")
  rescue
    "You can find your representative by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end


data = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
data.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislator_names = legislators_by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legislator_names}"
end
