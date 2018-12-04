Spree::Product.class_eval do
  scope :with_property_values, -> (values_array) { joins(:properties).
    where("#{Spree::ProductProperty.table_name}.value IN (?)", values_array)}
  scope :with_option_values,   -> (values_array) { joins(variants_including_master: :option_values).
    where("#{Spree::OptionValue.table_name}.name IN (?)", values_array).distinct }
end
