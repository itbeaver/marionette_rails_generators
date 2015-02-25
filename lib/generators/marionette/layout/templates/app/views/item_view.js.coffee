@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.<%= title.capitalize %>Layout extends App.Views.ItemView
    template: '<%= title.underscore %>'