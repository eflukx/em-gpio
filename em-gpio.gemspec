# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'em-gpio/version'

Gem::Specification.new do |gem|
  gem.name          = "em-gpio"
  gem.version       = EventMachine::Gpio::VERSION
  gem.authors       = ["Anup Narkhede"]
  gem.email         = ["anup.narkhede@gmail.com"]
  gem.description   = %q{Eventmachine based GPIO library for Raspberry Pi}
  gem.summary       = %q{Evented GPIO library for Raspberry Pi}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "eventmachine", "1.0.1"
  gem.add_dependency "mocha"
end
