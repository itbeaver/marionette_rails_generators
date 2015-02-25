@Backbone.app.module "Views.<%= @module.capitalize %>", (<%= @module.capitalize %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.capitalize %>.<%= title.capitalize %> extends App.Views.ItemView
    template: '<%= @module.underscore %>/<%= title.underscore %>'
