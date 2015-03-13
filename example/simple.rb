require "hermes_gps"

scanner = GPSScanner.new

scanner.subscribe("GGA") do |data|
  gga = data[1]
  puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  puts "altitude #{gga.altitude}#{gga.altitude_unit}"
end
Hermes::GPS::Superviser.run
