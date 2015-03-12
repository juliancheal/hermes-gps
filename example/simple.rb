require "hermes_gps"

scanner = Hermes::GPS::Client.new.connect('/dev/tty.SLAB_USBtoUART', 4800)

scanner.parse_nmea do |data|
  lat = data[:latitude]
  lon = data[:longitude]

  puts "Lat: #{lat}, Lon: #{lon}" unless lat.nil? && lon.nil?
end
