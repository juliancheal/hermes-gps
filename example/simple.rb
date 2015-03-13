require "hermes_gps"

scanner = GPSScanner.new

scanner.subscribe("trol") do |data|
  lat = data[1][:latitude]
  lon = data[1][:longitude]

  puts "Lat: #{lat}, Lon: #{lon}" unless lat.nil? && lon.nil?
end
Hermes::GPS::Superviser.run
