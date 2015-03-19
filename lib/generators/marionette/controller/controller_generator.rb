require 'generators/marionette/resource_helpers'

# Controller generator
#
# Example:
#
#   rails g marionette:controller root
#   rails g marionette:controller root index show
class Marionette::ControllerGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates controller'

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, banner: "title",
                             desc: "Controller title"
  argument :actions, type: :array, banner: "ACTION ACTION", default: ['index', 'new', 'show', 'edit'],
                             desc: "Actions for the resource controller"
  class_option :with_views, type: :boolean, default: false,
                             desc: "Generate with views"

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
  end

  def generate_view
    @with_views = options[:with_views]
    if @with_views
      template 'app/controllers/controller_with_views.js.coffee',
               "#{backbone_path}/app/controllers/#{@title.underscore}_controller.js.coffee"
      @actions.each do |act|
        generate 'marionette:view', "#{@title}/#{act}", 'ItemView'
      end
    else
      template 'app/controllers/controller.js.coffee',
             "#{backbone_path}/app/controllers/#{@title.underscore}_controller.js.coffee"
    end
  end
end
