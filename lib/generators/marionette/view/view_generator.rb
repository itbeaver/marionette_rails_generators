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
  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
    @partial = options[:partial]
    @titletemplate = @title
    @titletemplate = '_' + @titletemplate if @partial
  end

  def layout
    # if @module == 'All'
      @begin_layout = "@Backbone.app.module \"Views.Layouts\", (Layouts, App, Backbone, Marionette, $, _) ->\n"
      @layout = %(
  class Layouts.#{@title.camelcase}Layout extends App.Views.Layout
    template: 'layouts/#{@titletemplate.underscore}'
    regions:
      bodyRegion: "#body"
)
#     else
#       @begin_layout = "@Backbone.app.module \"Views.Layouts.#{@module.camelcase.gsub('::', '.')}\", (#{@module.camelcase.gsub('::', '.').split('.').last.to_s}, App, Backbone, Marionette, $, _) ->\n"
#       @layout = %(
#   class #{@module.camelcase.gsub('::', '.').split('.').last.to_s}.#{@title.camelcase}Layout extends App.Views.Layout
#     template: 'layouts/#{@titletemplate.underscore}'
#     regions:
#       bodyRegion: "#body"
# )
#     end
    @layout = @begin_layout + @layout
  end


  def generate_view
    case type
    when 'layout', 'Layout'
      unless @partial
        if File.exist?("#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee")
          append_file "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee", @layout.gsub(@begin_layout, '')
        else
          create_file "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee", @layout
        end
      end
      template 'app/templates/layouts/application.jst.eco',
               "#{javascript_path}/backbone/app/templates/layouts/#{ @titletemplate.underscore }.jst.eco"
    when 'item_view', 'ItemView', 'partial'
      @partial = true if type == 'partial'
      unless @partial
        template 'app/views/item_view.js.coffee',
                 "#{javascript_path}/backbone/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/item_view.jst.eco',
               "#{javascript_path}/backbone/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    else
      puts "Type [#{type}] didn't supported. Feel free to submit issue https://github.com/itbeaver/marionette_rails_generators/issues"
    end
  end
end
