#!/usr/bin/ruby
#Written by Stephen Beckstrand
require 'active_support/time'

puts "Hello! Welcome to the Timezone conversion script. Please supply a time, timezone and date. Please use the following formats:"

puts "\n  Time: Please use a 24 hour clock. Example of this would be 16:00 for 4:00PM.\n  Timezone: You can use either an abriviation (ex. MST), or hour offset in a format of {+/-}####  (ex. -0700 and +0700).\n  Date: Please provide date in the format of MM/DD/YYYY.\n\n  Here are a few examples:\n\n  13:00 UTC 02/17/2017\n  17:00 EST 04/02/2017\n  19:00 +0700 01/05/2099\n\n"

puts "\n If the time zone you specify is not recognized you may need to specify the offset value instead. Values can be seen here: https://en.wikipedia.org/wiki/List_of_time_zone_abbreviations\n\n"
print "(time, timezone, date) >"

sTime = gets.chomp

$sYear = sTime.split("/")[2]
$sDay = sTime.split("/")[1]
$sMonth = sTime.split(/[\s \/]/)[2]
$sHour = sTime.split(":")[0]
$sMinutes = sTime.split(":")[1]
$sTimezone = sTime.split(" ")[1]

if $sTimezone.include? "+" 
  $sTimezone.insert(3, ":")
else
  sOffset = Time.zone_offset("#{$sTimezone}")
  if sOffset == nil
    puts "Sorry, that is not a recognized time zone, Please manually include timezone offset"
    exit
  else
    sOffset = sOffset / 3600
  end
  sOffset = sOffset.to_s.insert(1, "0")
  sOffset = sOffset.insert(3, ":00")
  $sTimezone = sOffset
end
  
newTime = Time.new($sYear, $sMonth, $sDay, $sHour, $sMinutes, 0, "#{$sTimezone}")
print "Converted time in ETC: "
puts newTime.in_time_zone('Eastern Time (US & Canada)')
