require 'timecop'
require 'spec_helper'

RSpec.describe Spree::HomeController, type: :controller do
  routes { Spree::Core::Engine.routes }

  describe '#index' do
    context 'price filter' do
      let!(:cheap_product)     { create :base_product, price: 10 }
      let!(:expensive_product) { create :base_product, price: 100 }

      it 'should return cheap product' do
        get :index, params: { filters: { min_price_range: 5, max_price_range: 20 } }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [cheap_product]
      end

      it 'should return expensive product' do
        get :index, params: { filters: { min_price_range: 50, max_price_range: 101 } }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [expensive_product]
      end

      it 'should return both products' do
        get :index, params: { filters: { min_price_range: 9, max_price_range: 101 } }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [expensive_product, cheap_product]
      end
    end

    context 'property filter' do
      let! (:property)      { create :property     }
      let! (:product_red)   { create :base_product }
      let! (:product_blue)  { create :base_product }
      let! (:property_blue) { create :product_property, product: product_blue, property: property, value: 'Blue' }
      let! (:property_red)  { create :product_property, product: product_red,  property: property, value: 'Red'  }

      it 'should return product with property value' do
        get :index, params: { filters: { properties: { types: ['Red'] } } }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_red]
      end
    end

    context 'sorting' do
      before { Spree::FiltersConfiguration::Config.allowed_sortings += [:descend_by_updated_at, :ascend_by_master_price, :descend_by_master_price, :ascend_by_name, :descend_by_name] }
      let! (:product_red)   { create :base_product, price: 10, name: 'Zulu' }
      before { Timecop.travel Time.now + 5.minutes }
      let! (:product_blue)  { create :base_product, price: 20, name: 'Alpha' }

      it 'should return products in order :descend_by_updated_at' do
        get :index, params: { sorting: 'descend_by_updated_at' }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_blue, product_red]
      end

      it 'should return products in order :ascend_by_master_price' do
        get :index, params: { sorting: 'ascend_by_master_price' }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_red, product_blue]
      end

      it 'should return products in order :descend_by_master_price' do
        get :index, params: { sorting: 'descend_by_master_price' }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_blue, product_red]
      end

      it 'should return products in order :ascend_by_name' do
        get :index, params: { sorting: 'ascend_by_name' }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_blue, product_red]
      end

      it 'should return products in order :descend_by_name' do
        get :index, params: { sorting: 'descend_by_name' }

        expect(response.status).to eq(200)
        expect(assigns[:products]).to eq [product_red, product_blue]
      end
    end
  end
end
