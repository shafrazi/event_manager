# require "json"
# require "open-uri"
require "pp"
require "erb"
#
# data = open("https://www.googleapis.com/civicinfo/v2/representatives?address=80203&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody&key=AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw").read
# json = JSON.parse(data)
# pp json["officials"]

require "google/apis/civicinfo_v2"

civicinfo = Google::Apis::CivicinfoV2::CivicInfoService.new
civicinfo.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

response = civicinfo.representative_info_by_address(address: 80203, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])

p response.officials[0].name


meaning_of_life = 42

question = "The answer to the ultimate question of life, the universe and everything is  <%= meaning_of_life %>"
template = ERB.new(question)

results = template.result(binding)
puts results
p binding.local_variables
