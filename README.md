# Pronto::Infer

<!-- [![Gem Version](https://badge.fury.io/rb/pronto-infer.svg)](http://badge.fury.io/rb/pronto-infer) -->
<!-- [![Build Status](https://travis-ci.org/seikichi/pronto-infer.svg?branch=master)](https://travis-ci.org/seikichi/pronto-infer) -->
<!-- [![Coverage Status](https://coveralls.io/repos/seikichi/pronto-infer/badge.svg?branch=master&service=github)](https://coveralls.io/github/seikichi/pronto-infer?branch=master) -->

[Pronto](https://github.com/mmozuras/pronto) runner for [Infer](https://fbinfer.com/).

## Configuration

You need to specify location of infer output by passing `PRONTO_INFER_OUT_DIR` env variable e.g:

```bash
PRONTO_INFER_OUT_DIR=infer-out run --index
```

See [seikichi/pronto-infer-example](https://github.com/seikichi/pronto-infer-example) for more details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pronto-infer
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pronto-infer

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seikichi/pronto-infer.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
