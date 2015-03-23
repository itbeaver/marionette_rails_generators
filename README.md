# MarionetteRailsGenerators

[![Code Climate](https://codeclimate.com/github/itbeaver/marionette_rails_generators/badges/gpa.svg)](https://codeclimate.com/github/itbeaver/marionette_rails_generators)

With MarionetteRailsGenerators you can generate entities, controllers, views and scaffold BackboneMarionette app with rails-like structure
Simply try this!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marionette_rails_generators'
```

And then execute:

    $ bundle

Backbone(1.1.2) and Marionette(2.4.1) are loaded from the gem 'backbone-rails' and gem 'marionette-rails' accordingly.
To install backbone-marionette app execute
```ruby
rails generate marionette:install
```

## Usage

After install, start server, at the root you will see welcome page.

You can use these generators:
`rails generate marionette:scaffold Title [title:string description:text] [options]`
`rails generate marionette:model Title [title:string description:text] [options]`
`rails generate marionette:view Title Type [title:string description:text] [options]`
`rails generate marionette:controller Title [action action] [options]`
For more information about command run it in console

## Contributing

Feel free to contribute!

1. Fork it ( https://github.com/itbeaver/marionette_rails_generators/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
