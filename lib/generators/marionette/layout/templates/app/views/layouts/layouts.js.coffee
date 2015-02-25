@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.<%= title.capitalize %>Layout extends App.Views.Layout
    template: 'layouts/<%= title %>'
    regions:
      bodyRegion: "#body"
