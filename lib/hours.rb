require "csv"
require "date"

data = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
hours_arr = []
data.each do |row|
  reg_date = row[:regdate]
  reg_time = reg_date.split(" ")[1]
  date_obj = DateTime.strptime(reg_time, "%H:%M")
  hours_arr << date_obj.hour
end

hash = {}
hours_arr.each do |i|
  if hash[i]
    hash[i] += 1
  else
    hash[i] = 1
  end
end

p hash
