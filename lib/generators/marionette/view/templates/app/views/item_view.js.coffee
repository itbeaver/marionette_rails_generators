@Backbone.app.module "Views.<%= @module.camelcase %>", (<%= @module.camelcase %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.camelcase %>.<%= @title.camelcase %> extends App.Views.ItemView
    template: '<%= @module.underscore %>/<%= @titletemplate.underscore %>'
