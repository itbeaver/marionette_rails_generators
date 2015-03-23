@Backbone.app = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "before:start", (options) ->
    if options
      App.environment = options.environment if options.environment

  App.addRegions
    mainRegion:   "#main-region"

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.on "start", ->
    if @startHistory
      @startHistory()
    else
      Backbone.history.start if Backbone.history

  App
