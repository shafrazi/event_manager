# require "json"
# require "open-uri"
require "pp"
#
# data = open("https://www.googleapis.com/civicinfo/v2/representatives?address=80203&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody&key=AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw").read
# json = JSON.parse(data)
# pp json["officials"]

require "google/apis/civicinfo_v2"

civicinfo = Google::Apis::CivicinfoV2::CivicInfoService.new
civicinfo.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

response = civicinfo.representative_info_by_address(address: 80203, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])

p response.officials[0].name
