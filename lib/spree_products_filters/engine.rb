module SpreeProductsFilters
  class Engine < ::Rails::Engine
    require 'spree/core'

    isolate_namespace Spree

    engine_name 'spree_products_filters'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.register.filters_configuration", before: :load_config_initializers do |app|
      Spree::FiltersConfiguration::Config = Spree::FiltersConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
