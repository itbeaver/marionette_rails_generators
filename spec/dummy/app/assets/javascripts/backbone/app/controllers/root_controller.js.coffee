@Backbone.app.module "Controllers.All", (All, App, Backbone, Marionette, $, _) ->

  class All.Root extends App.Controllers.Application
    initialize: (args={}) ->
      args.action = '' unless args.action
      switch args.action
        when 'index'
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            indexView = new App.Views.Root.Index
            @show indexView, region: @layout.bodyRegion
          @show @layout
        else
          console.log('Not found')
