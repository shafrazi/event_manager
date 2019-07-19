require "csv"
require "google/apis/civicinfo_v2"
require "erb"

puts "EventManager Initilaized!"

template_letter = File.read("form_letter.html")

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  civicinfo = Google::Apis::CivicinfoV2::CivicInfoService.new
  civicinfo.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
  begin
    legislators = civicinfo.representative_info_by_address(address: zipcode, levels: "country", roles: ["legislatorUpperBody", "legislatorLowerBody"])
    legislators = legislators.officials
  rescue
    "You can find your representative by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  file_name = "output/thanks_#{id}.html"

  File.open(file_name, "w") do |file|
    file.puts(form_letter)
  end
end


data = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

template_letter = File.read("form_letter.html.erb")
erb_template = ERB.new(template_letter)

data.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislator_names = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

end
