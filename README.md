# RangeCompacter

It `compact`s ranges into array of arrays.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'range_compacter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install range_compacter

## Usage

With ranges:

```ruby
item1 = 1..100
item2 = 20..40
item3 = 60..120
item4 = 100..200
compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4)
compacter.compact(30..70) # => [item1, [item2, item3]]
```

With objects responding to `begin`, `end` and `cover?`:

```ruby
class Item
  def initialize(id, range)
    @id = id
    @range = range
  end

  def begin
    @range.begin
  end

  def end
    @range.end
  end

  def cover?(it)
    @range.cover?(it)
  end
end

item1 = Item.new 1, 1..100
item2 = Item.new 2, 20..40
item3 = Item.new 3, 60..120
item4 = Item.new 4, 100..200
compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4)
compacter.compact(30..70) # => [item1, [item2, item3]]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okuramasafumi/range_compacter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RangeCompacter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/okuramasafumi/range_compacter/blob/master/CODE_OF_CONDUCT.md).
