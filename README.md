# FastFoodNutrition

The Fast Food Nutrition gem is a command line interface tool that will get nutrition information for menu items from several of the top Fast Food and Quick service restaurants in the country.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Fast_Food_Nutrition'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Fast_Food_Nutrition

## Usage

Once installed, the lines below will run the gem:

    require 'Fast_Food_Nutrition'
    Welcome.new.intro

User will select a restaurant from the list supplied, then choose a category, then choose and item. The nutrition information for the item will be returned. User will have to option to search for another item or end the program.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github minasman>/Fast_Food_Nutrition. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FastFoodNutrition project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/Fast_Food_Nutrition/blob/master/CODE_OF_CONDUCT.md).
