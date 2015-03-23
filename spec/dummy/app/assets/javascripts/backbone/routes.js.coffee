@Backbone.app.module "Router", (Router, App, Backbone, Marionette, $, _) ->

  class Router extends Marionette.AppRouter
    appRoutes:
      "(/)": "root"

  API =
    root: ->
      console.log 'Hello world!'
      new App.Controllers.All.Root(action: 'index')

  App.addInitializer ->
    Backbone.app.router = new Router
      controller: API