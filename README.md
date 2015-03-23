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
To install backbone-marionette app, execute:
```ruby
rails generate marionette:install
```

So now in your `application.js` you can see:

```
//= require jquery.spin
//= require underscore
//= require backbone
//= require backbone.marionette
//= require backbone-syphon						// For forms serialize and deserialize

//= require ./backbone/before_backbone
//= require ./backbone/app 						// App initializer
//= require_tree ./backbone/base 				// Base views, controller, entity, entitycollection
//= require_tree ./backbone/config				// Configuration (sync method, helper controllers, views and entities)
//= require_tree ./backbone/app/templates		// jst.eco templates
//= require_tree ./backbone/app/views			// View class
//= require_tree ./backbone/app/models			// Entities
//= require_tree ./backbone/app/controllers		// Controllers
//= require ./backbone/routes					// navigate to controller#action (initialize controller with specified action)
//= require ./backbone/after_backbone
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
