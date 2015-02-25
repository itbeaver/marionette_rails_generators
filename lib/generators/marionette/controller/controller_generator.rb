require 'generators/marionette/resource_helpers'

# Controller generator
#
# Example:
#
#   rails g marionette:controller root
class Marionette::ControllerGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates controller'

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string
  argument :args, type: :array, default: ['index', 'new', 'show', 'edit']

  def generate_view
    @title = title
    @args = args

    template 'app/controllers/controller.js.coffee',
             "#{javascript_path}/backbone/app/controllers/#{title.underscore}.js.coffee"
  end
end
