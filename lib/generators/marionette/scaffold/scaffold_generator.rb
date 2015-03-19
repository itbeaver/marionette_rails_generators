require 'generators/marionette/resource_helpers'
require 'generators/marionette/attribute'

# Scaffold generator
#
# Example:
#
class Marionette::ScaffoldGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(
    pending
  )

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, required: true, banner: 'Entity'
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
    @one = @title.singularize
    @many = @title.pluralize
    @attributes = []
    @schema.each do |a|
      @attributes << Marionette::Attribute.new(a[0], a[1])
    end
  end

  def scaffold
    generate "marionette:model #{@one.camelcase} #{@schema.map {|a| "#{a[0]}:#{a[1]}"}.join(' ')}"

    #form
    template 'templates/_form.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/_form.jst.eco"
    #empty
    generate "marionette:view #{@many.underscore}/_empty ItemView --without-template"
    template 'templates/_empty.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/_empty.jst.eco"
    #post
    generate "marionette:view #{@many.underscore}/_#{@one.underscore} ItemView --without-template"
    view_attr @many.underscore + "/_#{@one.underscore}", %(
    tagName: "tr"
    triggers:
      "click .#{@one.underscore}-delete" : "#{@one.underscore}:delete:clicked"
)
    template 'templates/_post.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/_#{@one.underscore}.jst.eco"
    #edit
    generate "marionette:view #{@many.underscore}/edit CompositeView --without-template"
    view_attr @many.underscore + '/edit', %(
    triggers:
      "click .#{@one.underscore}-save" : "#{@many.underscore}:save:clicked"

    onShow: ->
      Backbone.Syphon.deserialize(@, @.model.attributes)
      @listenTo @, "#{@many.underscore}:save:clicked", (child, args) ->
        data = Backbone.Syphon.serialize(@)
        #{@one.underscore} = child.model
        #{@one.underscore}.set(data)
        #{@one.underscore}.saveSuccess = (check, und, model, response) ->
          App.navigate '#{@many.underscore}/' + response.id
        #{@one.underscore}.saveError = (check, und, model, response) ->
          console.log response
          alert('error')
        #{@one.underscore}.save()
)
    template 'templates/edit.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/edit.jst.eco"
    #index
    generate "marionette:view #{@many.underscore}/index CompositeView --without-template"
    view_attr @many.underscore + '/index', %(
    childView: #{@many.camelcase}.#{@one.camelcase}
    emptyView: #{@many.camelcase}.Empty
    childViewContainer: "tbody"

    onShow: ->

      @listenTo @, "childview:#{@one.underscore}:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete \#{model.get("name")}?"
          model.destroy()
)
    template 'templates/index.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/index.jst.eco"
    #new
    generate "marionette:view #{@many.underscore}/new CompositeView --without-template"
    view_attr @many.underscore + '/new', %(
    triggers:
      "click .#{@one.underscore}-create" : "#{@many.underscore}:create:clicked"

    onShow: ->
      @listenTo @, "#{@many.underscore}:create:clicked", (child, args) ->
        data = Backbone.Syphon.serialize(@)
        #{@one.underscore} = new App.Entities.All.#{@one.camelcase}
        #{@one.underscore}.set(data)
        #{@one.underscore}.saveSuccess = (check, und, model, response) ->
          App.navigate '#{@many.underscore}/' + response.id
        #{@one.underscore}.saveError = (check, und, model, response) ->
          console.log response
          alert('error')
        #{@one.underscore}.save()
)
    template 'templates/new.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/new.jst.eco"
    #show
    generate "marionette:view #{@many.underscore}/show CompositeView --without-template"
    view_attr @many.underscore + '/show', %(
    triggers:
      "click .#{@one.underscore}-delete" : "#{@one.underscore}:delete:clicked"

    onShow: ->
      @listenTo @, "#{@one.underscore}:delete:clicked", (child, args) ->
        model = child.model
        if confirm "Are you sure you want to delete \#{model.get("name")}?"
          model.destroy()
          App.navigate '/#{@many.underscore}'
)
    template 'templates/show.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/show.jst.eco"

    generate "marionette:controller #{@many.underscore}"
    controller_attr @many.underscore + '_controller', :index, %(
          #{@many.underscore} = new App.Entities.All.#{@one.camelcase}Collection
          #{@many.underscore}.fetch
            reset: true
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            indexView = new App.Views.#{@many.camelcase}.Index(collection: #{@many.underscore})
            @show indexView, region: @layout.bodyRegion, loading: true
          @show @layout, loading: false
)
    controller_attr @many.underscore + '_controller', :new, %(
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            newView = new App.Views.#{@many.camelcase}.New
            @show newView, region: @layout.bodyRegion, loading: true
          @show @layout, loading: false
)
    controller_attr @many.underscore + '_controller', :show, %(
          #{@one.underscore} = new App.Entities.All.#{@one.camelcase} id: args.id
          #{@one.underscore}.fetch
            reset: true
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            showView = new App.Views.#{@many.camelcase}.Show(model: #{@one.underscore})
            @show showView, region: @layout.bodyRegion, loading: true
          @show @layout, loading: false
)
    controller_attr @many.underscore + '_controller', :edit, %(
          #{@one.underscore} = new App.Entities.All.#{@one.camelcase} id: args.id
          #{@one.underscore}.fetch
            reset: true
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            editView = new App.Views.#{@many.camelcase}.Edit(model: #{@one.underscore})
            @show editView, region: @layout.bodyRegion, loading: true
          @show @layout, loading: false
)
  end
end
