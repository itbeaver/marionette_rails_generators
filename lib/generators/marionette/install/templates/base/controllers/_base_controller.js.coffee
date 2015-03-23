@Backbone.app.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Application extends Marionette.Controller

    constructor: (options = {}) ->
      @region = options.region or App.request "default:region"
      super options
      @_instance_id = _.uniqueId("controller")
      App.request "register:instance", @, @_instance_id

    close: ->
      console.log 'closing', @
      App.request "unregister:instance", @, @_instance_id
      super

    show: (view, options = {}) ->
      _.defaults options,
        loading: false
        region: @region
        preventDestroy: false

      @setMainView view
      callback = onShowAllView
      @_manageView view, options, callback

    setMainView: (view) ->

      # the first view we show is always going to become the mainView of our
      # controller (whether its a layout or another view type). So if this
      # *is* a layout, when we show other tegions inside of that layout, we
      # check for the existance of a naminView first, so our controller is only
      # closed down when the original mainView is closed.

      return if @_mainView
      @_mainView = view
      @listenTo view, "close", @close

    _manageView: (view, options, callback) ->
      if options.loading
        App.request "show:loading", view, options, callback
      else
        options.region.show view, options