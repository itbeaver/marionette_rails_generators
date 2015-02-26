@Backbone.app.module "Router", (Router, App, Backbone, Marionette, $, _) ->

  class Router extends Marionette.AppRouter
    appRoutes:
      "(/)": "root"

  API =
    root: ->
      console.log 'Hello world!'

  App.addInitializer ->
    new Router
      controller: API