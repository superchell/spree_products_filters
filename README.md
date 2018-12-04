# Spree::Products::Filters

Current gem provides easy installation of advanced product filters for your Spree Commerce application.

Spree Commerce versions:
- Spree Core - 3.6
- Spree Auth Devise - 3.3

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spree-products-filters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spree-products-filters

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_products_filters:install
```

## Usage

Before use add allowed sorting scopes in config/initializers/spree.rb

```shell
Spree::FiltersConfiguration::Config.allowed_sortings += [:descend_by_updated_at, :ascend_by_master_price, :descend_by_master_price, :ascend_by_name, :descend_by_name]
```

Some properties can be removed from filters, for example 'Material', 'Size' (add this line to config/initializers/spree.rb):

```shell
Spree::FiltersConfiguration::Config.hidden_properties += ['Material', 'Size']
```

## Testing

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
