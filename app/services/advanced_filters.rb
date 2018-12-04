class AdvancedFilters
  def initialize(params = {}, products)
    @params   = params
    @products = products
  end

  def filter_results
    @params[:filters] ||= {}
    params_clone = @params[:filters].deep_dup.delete_if { |_query, value| value.blank? }

    products    = filters_merger(params_clone, @products).distinct
    min_price   = products.map(&:price).min.to_i
    max_price   = products.map(&:price).max.round.to_i
    price_range = {min_range: params_clone[:min_price_range].present? ? params_clone[:min_price_range].to_i : min_price,
                   max_range: params_clone[:max_price_range].present? ? params_clone[:max_price_range].to_i : max_price,
                   collection_min_price: min_price,
                   collection_max_price: max_price}
    properties = products.map(&:properties).flatten.uniq
    properties = properties.blank? ? nil : allowed_properties(properties)

    product_properties = products.map(&:product_properties).flatten.uniq.map(&:value).uniq
    product_properties = product_properties.blank? ? nil : product_properties

    result_hash = { properties: properties, product_properties: product_properties,
                    products:   products,   price_range:        price_range }

    if @params[:controller] == 'spree/taxons' && @params[:action] == 'show'
      option_types = products.map(&:option_types).flatten.uniq
      option_types = option_types.blank? ? nil : option_types

      result_hash[:option_types] = option_types
    end

    result_hash
  end

  private

  def filters_merger(params, products)
    if params[:min_price_range].present? && params[:max_price_range].present?
      products = products.send('price_between', params[:min_price_range].to_i, params[:max_price_range].to_i)
    end

    if params[:option_types].present? && !params[:option_types][:names].blank?
      products = products.with_option_values(params[:option_types][:names])
    end

    if params[:properties].present? && !params[:properties][:types].blank?
      products = products.with_property_values(params[:properties][:types])
    end

    products
  end

  def allowed_properties(properties)
    if Spree::FiltersConfiguration::Config.hidden_properties.any?
      properties - Spree::Property.where(name: Spree::FiltersConfiguration::Config.hidden_properties)
    else
      properties
    end
  end
end
