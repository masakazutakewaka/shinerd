# [WIP] Shinerd
ERD Generator interactive on browser.

## Usage
Add this to your `routes.rb`.
```ruby
if Rails.env.development?
  mount ShinerdEngine => 'shinerd/index'
end
```

Open `localhost:3000/shinerd`.

![shinerd_demo](https://user-images.githubusercontent.com/26586593/64940441-d53efb00-d818-11e9-9b6e-14c0b2d6b442.gif)

## Installation
Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'shinerd'
end
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install shinerd
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
