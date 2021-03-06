# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hermes_gps/version'

Gem::Specification.new do |spec|
  spec.name          = "hermes_gps"
  spec.version       = Hermes::GPS::VERSION
  spec.authors       = ["Julian Cheal"]
  spec.email         = ["julian.cheal@gmail.com"]
  spec.summary       = "Herms-gps is a Ruby GPS scanner/parser"
  spec.description   = ""
  spec.homepage      = "http://github.com/juliancheal/hermes-gps"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "celluloid", "~> 0.16.0"
  spec.add_runtime_dependency "celluloid-io", "~> 0.15.0"
  spec.add_runtime_dependency "celluloid-io-serialport", "~> 0.0.1"
  spec.add_runtime_dependency "rubyserial", "~> 0.2.2"

end
