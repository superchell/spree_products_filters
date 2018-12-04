Deface::Override.new(
  virtual_path: 'spree/taxons/show',
  name: 'advanced_filters',
  insert_before: "[data-hook='taxon_sidebar_navigation']",
  text: "<%= render 'spree/shared/advanced_filters'%>"
)
