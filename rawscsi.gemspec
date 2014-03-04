# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rawscsi/version'

Gem::Specification.new do |spec|
  spec.name          = "rawscsi"
  spec.version       = Rawscsi::VERSION
  spec.authors       = ["Steven Li"]
  spec.email         = ["StevenJLi@gmail.com"]
  spec.description   = %q{Rails Amazon Web Services Cloud Search Interface}
  spec.summary       = %q{Adds a service object which searches over search domain and returns AR objects}
  spec.homepage      = "https://github.com/StevenJL/rawscsi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "activerecord"
  spec.add_dependency "httparty"
end
