require 'generators/marionette/resource_helpers'

# Model generator
#
# Example:
#
#   rails g marionette:model Post title:string description:text
class Marionette::ModelGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates entity [Title] with schema [schema] and [Title]Collection associated with entity'

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, required: true, banner: 'Entity'
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'

  def generate_entity
    template 'app/models/entity.js.coffee',
             "#{javascript_path}/backbone/app/models/#{@title.underscore}.js.coffee"
  end
end
