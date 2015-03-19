require 'generators/marionette/resource_helpers'

# Model generator
#
# Example:
#
#   rails g marionette:model Post title:string description:text
class Marionette::ModelGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(
  	Creates entity [Title] with schema [schema] and [Title]Collection associated with entity
    Module will be parsed from title

    Example:

      rails g marionette:entity posts title:string description:text
        Entity => 'Backbone.app.Entities.All.Posts'
      rails g marionette:entity blogs/posts
        Entity => 'Backbone.app.Entities.Blogs.Posts'
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
