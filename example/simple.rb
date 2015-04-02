require "hermes_gps"

scanner = GPSScanner.new({name: :flight_recorder, adaptor: :flight_recorder, port: "/dev/tty.usbmodem1a1241", baud: 115200})

scanner.subscribe("GGA") do |data|
  puts "data: #{data}"
  gga = data[1]
  puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  puts "altitude #{gga.altitude}#{gga.altitude_unit}"
  puts "satellites tracked #{gga.satellites_tracked}"
end
Hermes::GPS::Superviser.run
