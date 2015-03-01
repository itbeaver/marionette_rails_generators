require 'generators/marionette/resource_helpers'

# View generator
#
# Example:
#
#   rails g marionette:view layout application
class Marionette::ViewGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates view: type can be: [layout, item_view]'

  source_root File.expand_path('../templates', __FILE__)

  argument :type, type: :string
  argument :title, type: :string
  argument :module, type: :string, default: 'All'
  class_option :partial, type: :boolean, default: false,
                             desc: 'Generate partial template'
  def generate_view
    @partial = options[:partial]
    @titletemplate = @title
    @titletemplate = '_' + @titletemplate if @partial
    case type
    when 'layout'
      template 'app/views/layouts/layouts.js.coffee',
               "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee"
      template 'app/templates/layouts/application.jst.eco',
               "#{javascript_path}/backbone/app/templates/layouts/#{ @titletemplate.underscore }.jst.eco"
    when 'item_view'
      template 'app/views/item_view.js.coffee',
               "#{javascript_path}/backbone/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      template 'app/templates/item_view.jst.eco',
               "#{javascript_path}/backbone/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    else
      puts "That type didn't supported. Feel free to submit issue https://github.com/itbeaver/marionette_rails_generators/issues"
    end
  end
end
