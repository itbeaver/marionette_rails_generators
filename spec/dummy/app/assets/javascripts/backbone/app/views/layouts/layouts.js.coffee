@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ApplicationLayout extends App.Views.Layout
    template: 'layouts/application'
    regions:
      bodyRegion: "#body"
