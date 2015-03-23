require 'generators/marionette/resource_helpers'

# :nodoc:
class Marionette::ModelGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(Description:
    Stubs out a new model - Entity class and EntityCollection class.
    Pass the model name, either CamelCased or
    under_scored, and an optional list of attribute pairs as arguments.

    Optional list of attribute pairs can be represented as
    javascript object with 'schema' method.

    Attribute pairs are field:type arguments specifying the
    model's attributes.

    Example:
      rails g marionette:entity post title:string description:text
        generates entity 'Backbone.app.Entities.All.Post'
      rails g marionette:entity blogs/post
        generates entity 'Backbone.app.Entities.Blogs.Post'
  )

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, required: true, banner: 'Entity'
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
  end

  def generate_entity
    template 'app/models/entity.js.coffee',
             "#{backbone_path}/app/models/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
  end
end
