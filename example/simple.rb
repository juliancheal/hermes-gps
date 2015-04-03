require "hermes_gps"

flight_recorder = GPSScanner.new({name: :flight_recorder, adaptor: :flight_recorder, port: "/dev/tty.SLAB_USBtoUART", baud: 4800})

flight_recorder.subscribe("flight_recorder_GGA") do |data|
  gga = data[1]
  puts "data: #{data}"
  puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  puts "altitude #{gga.altitude}#{gga.altitude_unit}"
  puts "satellites tracked #{gga.satellites_tracked}"
end
Hermes::GPS::Superviser.run
