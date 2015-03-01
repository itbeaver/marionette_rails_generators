@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.<%= @title.camelcase %>Layout extends App.Views.Layout
    template: 'layouts/<%= @titletemplate.underscore %>'
    regions:
      bodyRegion: "#body"
