require 'generators/marionette/resource_helpers'

# View generator
#
# Example:
#
#   rails g marionette:view layout application
class Marionette::ViewGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(
    Creates view. Type values: [Layout, ItemView].
    Module will be parsed from title

    Example:

      rails g marionette:view index ItemView title:string description:text
        View => 'Backbone.app.Views.All.Index'
      rails g marionette:view posts/index ItemView title:string description:text
        View => 'Backbone.app.Views.Posts.Index'
      rails g marionette:view blogs/posts/index ItemView title:string description:text
        View => 'Backbone.app.Views.Blogs.Posts.Index'
  )

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string
  argument :type, type: :string
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'
  class_option :partial, type: :boolean, default: false,
                             desc: 'Generate partial template'
  class_option 'with-class', type: :boolean, default: false,
                             desc: 'Generate view class when generating partial template? (use with --partial)'

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
    @partial = options[:partial]
    @partial_class = options['with-class']
    @titletemplate = @title
    @titletemplate = '_' + @titletemplate if @partial
  end

  def layout
    @begin_layout = "@Backbone.app.module \"Views\", (Views, App, Backbone, Marionette, $, _) ->\n"
    @layout = %(
  class Views.#{@title.camelcase}Layout extends App.Views.Layout
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
