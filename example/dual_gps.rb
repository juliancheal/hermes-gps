require "hermes_gps"

arduino_gps = GPSScanner.new({name: :arduino_gps, adaptor: :flight_recorder, port: "/dev/tty.usbmodem1a1241", baud: 9600})
flight_recorder = GPSScanner.new({name: :flight_recorder, adaptor: :flight_recorder, port: "/dev/tty.SLAB_USBtoUART", baud: 4800})

arduino_gps.subscribe("arduino_gps_GGA") do |data|
  # puts data.inspect
  gga = data[1]
  puts "Arduino lat: #{gga.latitude}, long: #{gga.longitude}"
  # puts "data: #{data}"
  # puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  # puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  # puts "altitude #{gga.altitude}#{gga.altitude_unit}"
  # puts "satellites tracked #{gga.satellites_tracked}"
end

flight_recorder.subscribe("flight_recorder_GGA") do |data|
  gga = data[1]
  puts "Flight Recorder lat: #{gga.latitude}, long: #{gga.longitude}"
  # puts "data: #{data}"
  # puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  # puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  # puts "altitude #{gga.altitude}#{gga.altitude_unit}"
  # puts "satellites tracked #{gga.satellites_tracked}"
end
Hermes::GPS::Superviser.run
