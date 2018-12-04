module Spree
  class FiltersConfiguration < Preferences::Configuration
    attr_accessor :allowed_sortings, :hidden_properties
    # FiltersConfiguration
    def initialize
      @allowed_sortings  = []
      @hidden_properties = []
    end
  end
end
