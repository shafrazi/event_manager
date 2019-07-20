require "date"

date_obj = DateTime.strptime('03-02-2001 04:05:06 PM', '%d-%m-%Y %I:%M:%S %p')
p date_obj.minute
