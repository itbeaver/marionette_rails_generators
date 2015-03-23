@Backbone.app.module "Utilites.Loading", (Loading, App, Backbone, Marionette, $, _) ->

  class Loading.LoadingController extends App.Controllers.Application

    initialize: (options) ->
      { view, config } = options

      config = if _.isBoolean(config) then {} else config

      _.defaults config,
        loadingType: 'spinner'
        entities: @getEntities(view)
        debug: false

      switch config.loadingType
        when 'opacity'
          @region.currentView.$el.css '-moz-transition',  'opacity 1s ease-in-out' if @region.hasView()
          @region.currentView.$el.css '-ms-transition',  'opacity 1s ease-in-out' if @region.hasView()
          @region.currentView.$el.css '-o-transition',  'opacity 1s ease-in-out' if @region.hasView()
          @region.currentView.$el.css '-webkit-transition', 'opacity 1s ease-in-out' if @region.hasView()
          @region.currentView.$el.css 'opacity', 0 if @region.hasView()
        when 'spinner'
          loadingView = @getLoadingView()
          @show loadingView
        else
          throw new Error("Invalid loadingType")

      @showRealView view, loadingView, config, options.callback

    showRealView: (realView, loadingView, config, callback) ->
      unless callback
        callback = ->
          return false
      App.request 'when:fetched', config.entities, =>
        switch config.loadingType
          when "opacity"
            @region.currentView.$el.removeAttr "style" if @region.hasView()
          when "spinner"
            return realView.close() if @region.currentView isnt loadingView
        callback()

        @show realView unless config.debug

    getEntities: (view) ->
      _.chain(view).pick('model', 'collection').toArray().compact().value()

    getLoadingView: ->
      new Loading.LoadingView

  App.reqres.setHandler 'show:loading', (view, options, callback) ->
    new Loading.LoadingController
      view: view
      region: options.region
      config: options.loading
      callback: callback