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
  class_option 'with-view-class', type: :boolean, default: false,
                             desc: 'Generate view class when generating partial template? (use with --partial)'

  def vars
    @partial = options[:partial]
    @partial_class = options['with-view-class']
    @titletemplate = @title
    @titletemplate = '_' + @titletemplate if @partial
  end

  def layout
    @begin_layout = "@Backbone.app.module \"Views\", (Views, App, Backbone, Marionette, $, _) ->\n"
    @layout = %(
  class Views.#{@title.camelcase.gsub('::', '.')}Layout extends App.Views.Layout
    template: 'layouts/#{@titletemplate.underscore}'
    regions:
      bodyRegion: "#body"
)
    @layout = @begin_layout + @layout
  end


  def generate_view
    case type
    when 'layout', 'Layout'
      if !@partial || @partial_class
        if File.exist?("#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee")
          append_file "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee", @layout.gsub(@begin_layout, '')
        else
          create_file "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee", @layout
        end
      end
      template 'app/templates/layouts/application.jst.eco',
               "#{javascript_path}/backbone/app/templates/layouts/#{ @titletemplate.underscore }.jst.eco"
    when 'item_view', 'ItemView'
      if !@partial || @partial_class
        template 'app/views/item_view.js.coffee',
                 "#{javascript_path}/backbone/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/item_view.jst.eco',
               "#{javascript_path}/backbone/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    else
      puts "That type didn't supported. Feel free to submit issue https://github.com/itbeaver/marionette_rails_generators/issues"
    end
  end
end
