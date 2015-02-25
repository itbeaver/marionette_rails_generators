require 'generators/marionette/resource_helpers'

# Controller generator
#
# Example:
#
#   rails g marionette:controller:view root
#   rails g marionette:controller:view root index
class Marionette::Controller::ViewGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates controller with itemviews'

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, banner: "title",
                             desc: "Controller title"
  argument :actions, type: :array, banner: "ACTION ACTION", default: ['index', 'new', 'show', 'edit'],
                             desc: "Actions for the resource controller and generated views"

  def generate_view
    template 'app/controllers/controller.js.coffee',
             "#{javascript_path}/backbone/app/controllers/#{@title.underscore}_controller.js.coffee"
    @actions.each do |act|
      generate 'marionette:view', 'item_view', act, @title
    end
  end
end
