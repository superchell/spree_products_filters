Spree::Core::Search::Base.class_eval do
  def custom_retrieve_products
    @products = get_base_scope

    unless Spree::Config.show_products_without_price
      @products = @products.where('spree_prices.amount IS NOT NULL').where('spree_prices.currency' => current_currency)
    end

    @products
  end
end
