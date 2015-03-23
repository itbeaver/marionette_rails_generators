require 'generators/marionette/resource_helpers'
require 'generators/marionette/attribute'

# :nodoc:
class Marionette::ViewGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  include ActionView::Helpers::FormTagHelper
  desc %(Description:
    Stubs out a new view. Pass the view name, either
    CamelCased or under_scored, and a type of view as argument.

    Pass an optional list of attribute pairs as arguments for
    filling template with form.

    To create a view within a module, specify the view name as a
    path like 'parent_module/view_name'.

    This generates a view class in app/assets/javascripts/backbone/app/views
    and template in app/assets/javascripts/backbone/app/templates folder.

    Type may take the following values: partial, Layout,
    ItemView, CollectionView, CompositeView

    Layouts views appends to
      app/assets/javascripts/backbone/app/views/layouts/layouts.js.coffee

Example:
    rails g marionette:view index ItemView title:string description:text
      generates ItemView 'Backbone.app.Views.All.Index'
      and template filled with form
    rails g marionette:view posts/index ItemView title:string description:text
      generates ItemView 'Backbone.app.Views.Posts.Index'
      and template filled with form
    rails g marionette:view blogs/posts/index ItemView
      generates ItemView 'Backbone.app.Views.Blogs.Posts.Index'
      and stub template
  )

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string
  argument :type, type: :string
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'
  class_option 'without-template', type: :boolean, default: false, desc: 'generate View without template'

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
    @withouttempl = options['without-template']
    @partial = false
    @partial = true if type == 'partial'
    @titletemplate = @title
    @titletemplate = '_' + @titletemplate if @partial
    @attributes = []
    @schema.each do |a|
      @attributes << Marionette::Attribute.new(a[0], a[1])
    end
  end

  def layout
    @begin_layout = "@Backbone.app.module \"Views.Layouts\", (Layouts, App, Backbone, Marionette, $, _) ->\n"
    @layout = %(
  class Layouts.#{@title.camelcase}Layout extends App.Views.Layout
    template: 'layouts/#{@titletemplate.underscore}'
    regions:
      bodyRegion: "#body"
)
    @layout = @begin_layout + @layout
  end

  def generate_view
    case type
    when 'layout', 'Layout'
      unless @partial
        if File.exist?("#{backbone_path}/app/views/layouts/layouts.js.coffee")
          append_file "#{backbone_path}/app/views/layouts/layouts.js.coffee", @layout.gsub(@begin_layout, '')
        else
          create_file "#{backbone_path}/app/views/layouts/layouts.js.coffee", @layout
        end
      end
      template 'app/templates/layouts/application.jst.eco',
               "#{backbone_path}/app/templates/layouts/#{ @titletemplate.underscore }.jst.eco" unless @withouttempl
    when 'item_view', 'ItemView', 'partial'
      unless @partial
        template 'app/views/item_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/item_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco" unless @withouttempl
    when 'collection_view', 'CollectionView'
      unless @partial
        template 'app/views/collection_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/collection_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco" unless @withouttempl
    when 'composite_view', 'CompositeView'
      unless @partial
        template 'app/views/composite_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/composite_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco" unless @withouttempl
    else
      puts "Type [#{type}] didn't supported. Feel free to submit issue https://github.com/itbeaver/marionette_rails_generators/issues"
    end
  end
end
