Deface::Override.new(
  virtual_path: 'spree/products/index',
  name: 'advanced_filters',
  insert_before: "[data-hook='homepage_sidebar_navigation']",
  text: "<%= render 'spree/shared/advanced_filters'%>"
)
