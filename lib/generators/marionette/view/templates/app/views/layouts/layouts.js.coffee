@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.<%= @title.camelcase.gsub('::', '.') %>Layout extends App.Views.Layout
    template: 'layouts/<%= @titletemplate.underscore %>'
    regions:
      bodyRegion: "#body"
