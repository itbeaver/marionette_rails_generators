require 'generators/marionette/resource_helpers'
require 'generators/marionette/attribute'

# View generator
#
# Example:
#
#   rails g marionette:view layout application
class Marionette::ViewGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  include ActionView::Helpers::FormTagHelper
  desc %(
    Creates view. Type values: [partial, Layout, ItemView, CollectionView, CompositeView].
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

  def protect_against_forgery?
    false
  end

  def schema_form_generate
    @attributes = []
    @schema.each do |a|
      @attributes << Marionette::Attribute.new(a[0], a[1])
    end
    capture do
      @form = form_tag '' do
        @attributes.each do |attribute|
          concat "\n\n"
          concat '<div class="field">'.html_safe
          concat "\n"
          if attribute.password_digest?
            concat label_tag :password
            concat '<br>'.html_safe
            concat "\n"
            concat password_field_tag :password
            concat "\n\n"
            concat label_tag :password_confirmation
            concat '<br>'.html_safe
            concat "\n"
            concat password_field_tag :password_confirmation
          else
            concat label_tag(attribute.column_name.to_sym)
            concat '<br>'.html_safe
            concat "\n"
            concat eval("#{attribute.field_type.to_s}_tag(:#{attribute.column_name})")
          end
          concat "\n"
          concat '</div>'.html_safe
        end
        concat "\n\n"
        concat '<div class="actions">'.html_safe
        concat "\n"
        concat submit_tag
        concat "\n"
        concat '</div>'.html_safe
        concat "\n\n"
      end
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
               "#{backbone_path}/app/templates/layouts/#{ @titletemplate.underscore }.jst.eco"
    when 'item_view', 'ItemView', 'partial'
      @partial = true if type == 'partial'
      unless @partial
        template 'app/views/item_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/item_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    when 'collection_view', 'CollectionView'
      unless @partial
        template 'app/views/collection_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/collection_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    when 'composite_view', 'CompositeView'
      unless @partial
        template 'app/views/composite_view.js.coffee',
                 "#{backbone_path}/app/views/#{ @module.underscore }/#{ @title.underscore }.js.coffee"
      end
      template 'app/templates/composite_view.jst.eco',
               "#{backbone_path}/app/templates/#{ @module.underscore }/#{ @titletemplate.underscore }.jst.eco"
    else
      puts "Type [#{type}] didn't supported. Feel free to submit issue https://github.com/itbeaver/marionette_rails_generators/issues"
    end
  end
end
