require 'spec_helper'

RSpec.describe Spree::TaxonsController, type: :controller do
  routes { Spree::Core::Engine.routes }

  describe '#show' do
    let!(:taxon)          { create :taxon }
    let!(:product_m_size) { create :base_product, price: 10 }
    let!(:product_s_size) { create :base_product, price: 20 }
    let!(:option_m)       { create :option_value, name: 'size-m', presentation: 'M'}
    let!(:option_s)       { create :option_value, name: 'size-s', presentation: 'S'}
    let!(:variant_m_size) { create :base_variant, product: product_m_size }
    let!(:variant_s_size) { create :base_variant, product: product_s_size }

    before do
      product_m_size.taxons << taxon
      product_s_size.taxons << taxon
      product_m_size.option_types << option_m.option_type
      product_s_size.option_types << option_s.option_type
      variant_m_size.option_values << option_m
      variant_s_size.option_values << option_s
    end

    it 'should return product with option value' do
      get :show, params: { id: taxon, filters: { option_types: { names: ['size-m'] } } }

      expect(response.status).to eq(200)
      expect(assigns[:products]).to eq [product_m_size]
    end
  end
end
