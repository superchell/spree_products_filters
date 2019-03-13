# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_products_filters/version'

Gem::Specification.new do |spec|
  spec.name    = 'spree_products_filters'
  spec.version = SpreeProductsFilters::VERSION
  spec.author  = 'Jet Ruby Agency'

  spec.summary               = 'Advanced product filters for your Spree Commerce app'
  spec.description           = 'Advanced product filters for your Spree Commerce app'
  spec.email                 = 'for.oleg.mozolev@gmail.com'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.0'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.require_path = 'lib'
  spec.requirements << 'none'

  spec.add_runtime_dependency 'spree_core', '>= 3.6.0'
  spec.add_runtime_dependency 'haml'
  spec.add_runtime_dependency 'jquery-ui-rails'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'factory_bot_rails', '~> 4.10.0'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'capybara', '~> 2.1'
  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'rspec-rails',  '~> 3.7.1'
  spec.add_development_dependency 'rails-controller-testing'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'sass-rails'
end
