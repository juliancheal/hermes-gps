require "hermes_gps"

scanner = Hermes::GPS::Scanner.new('/dev/tty.SLAB_USBtoUART', 4800)

scanner.subscribe("") do |data|
  lat = data[:latitude]
  lon = data[:longitude]

  puts "Lat: #{lat}, Lon: #{lon}" unless lat.nil? && lon.nil?
end
# Hermes::GPS::Superviser.run
sleep
