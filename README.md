# Hermes_gps

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hermes_gps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hermes_gps

## Usage

```ruby
require "hermes_gps"

scanner = GPSScanner.new

scanner.subscribe("GGA") do |data|
  gga = data[1]
  puts "latitude #{gga.latitude}, direction #{gga.direction_latitude}"
  puts "longitude #{gga.longitude}, direction #{gga.direction_longitude}"
  puts "altitude #{gga.altitude}#{gga.altitude_unit}"
end
Hermes::GPS::Superviser.run
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hermes-gps/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
