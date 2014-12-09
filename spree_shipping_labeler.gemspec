# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY

  s.name        = 'spree_shipping_labeler'
  s.version     = '2.0.0'
  s.authors     = ["Daniel Pritchett"]
  s.email       = 'dpritchett@gmail.com'
  s.homepage    = 'http://github.com/coroutine/spree_shipping_labeler'
  s.summary     = 'Spree extension for providing shipping labels for FedEx shipments'
  s.description = 'Spree extension for providing shipping labels for FedEx shipments'
  s.required_ruby_version = '>= 1.8.7'
  s.rubygems_version      = '1.3.6'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('spree_core', '~> 2.0.0')

  s.add_development_dependency 'pry'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'simplecov'
end
