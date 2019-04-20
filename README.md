# Ruby::Mext music extensions for the ruby language (native ruby code)

[![Build Status](https://travis-ci.org/nicb/ruby-mext.svg?branch=master)](https://travis-ci.org/nicb/ruby-mext)
[![Maintainability](https://api.codeclimate.com/v1/badges/53686892aa9ee6a30ebb/maintainability)](https://codeclimate.com/github/nicb/ruby-mext/maintainability)

These are extensions of usual idiomatic `ruby` objects (i.e. `Numeric`,
`Array`, etc.) that make `ruby` a comfortable language for musicians.

It is the usual unfinished ever-expanding project. Feel free to contribute to
it in the form of pull requests if you are so inclined.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-mext'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-mext

## Usage

Just add anywhere in your code:

```ruby

require 'ruby-mext'
```

and boum! There you go. You have the extensions.

There should be some documentation here for each extension. Feel free to
contribute them! :-D

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicb/ruby-mext.

Please note: I am trying to keep this library *as simple and easy to use* as
possible. Let's not over-feature it as we (musicians) always do.
