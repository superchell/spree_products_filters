class AdvancedFilters
  def initialize(params = {}, products)
    @params   = params.permit!
    @products = products
  end

  def filter_results
    @params[:filters] ||= {}

    params_clone  = @params[:filters].permit!.deep_dup.delete_if { |_query, value| value.blank? }
    result_hash   = { properties: nil, product_properties: nil,
                      products:   [],   price_range:      nil }

    return result_hash if @products.blank?

    min_price              = @products.map(&:price).min.to_i
    max_price              = @products.map(&:price).max.round.to_i
    price_range            = {min_range: params_clone[:min_price_range].present? ? params_clone[:min_price_range].to_i : min_price,
                              max_range: params_clone[:max_price_range].present? ? params_clone[:max_price_range].to_i : max_price,
                              collection_min_price: min_price,
                              collection_max_price: max_price}
    result_hash[:price_range] = price_range

    properties               = @products.includes(:properties).map(&:properties).flatten.uniq
    result_hash[:properties] = allowed_properties(properties) unless properties.blank?

    product_properties               = @products.map(&:product_properties).flatten.uniq.map(&:value).uniq
    result_hash[:product_properties] = product_properties unless product_properties.blank?

    if @params[:controller] == 'spree/taxons' && @params[:action] == 'show'
      option_types               = @products.includes(:option_types).map(&:option_types).flatten.uniq
      result_hash[:option_types] = option_types unless option_types.blank?
    end

    products    = filters_merger(params_clone, @products).distinct
    result_hash[:products] = products

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

    if params[:properties].present? && params[:properties].keys.present?
      products = products.where(id: filtered_property_products(params[:properties]))
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

  def filtered_property_products(properties)
    res = []
    properties.each do |property_id, value|
      res << Spree::ProductProperty.where("property_id = ? AND value IN (?)", property_id, value).distinct.map(&:product_id)
    end

    if res.size <= 1
      res.flatten
    else
      res.inject(&:&)
    end
  end
end
