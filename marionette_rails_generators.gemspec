# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marionette_rails_generators/version'

Gem::Specification.new do |spec|
  spec.name          = "marionette_rails_generators"
  spec.version       = MarionetteRailsGenerators::VERSION
  spec.authors       = ["Russkikh Artem"]
  spec.email         = ["russkikhartem@itbeaver.co"]
  spec.summary       = %q{Backbone on Marionette. Rails generators}
  spec.description   = %q{Backbone on Marionette. Rails generators. Made to work with API}
  spec.homepage      = "http://itbeaver.co"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'backbone-rails', '~> 1.1.2'
  spec.add_runtime_dependency 'marionette-rails', '~> 2.3.2'
  spec.add_runtime_dependency "eco"

  spec.add_development_dependency "rails"
  spec.add_development_dependency "jasmine"
  spec.add_development_dependency "jquery-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end