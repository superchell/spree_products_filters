Deface::Override.new(virtual_path:  'spree/shared/_products',
                     insert_before: '#products[data-hook]',
                     partial:       'spree/shared/sorting_bar',
                     name:          'sorting_in_products')
