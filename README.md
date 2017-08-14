# DISCLAIMER: Test before use
I have not tested many of these endpoints given my own limited requirements. If you are making real exchanges, especially with more exotic coins, please test this implementation thoroughly.

# Ruby implementation of the Shapeshift.io public API

- Unofficial implementation
- Implements public REST API
- Full docs at [https://info.shapeshift.io/api](https://info.shapeshift.io/api)

## Installation

Add this line to your application's Gemfile:

`gem 'shapeshift_io'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install shapeshift_io`

## Usage

_Extended examples available at [Shapeshift.io](https://info.shapeshift.io/api)_

```
client = Shapeshift::Client.new
client.market_info('BTC_ETH')
```

### Contributing
- Fork it ( https://github.com/romanos/shapeshift-io/fork )
- Create your feature branch (`git checkout -b my-new-feature`)
- Commit your changes (`git commit -am 'Add some feature'`)
- Push to the branch (`git push origin my-new-feature`)
- Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
