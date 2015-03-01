@Backbone.app.module "Views.<%= @module.camelcase.gsub('::', '.') %>", (<%= @module.camelcase.gsub('::', '.') %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.camelcase.gsub('::', '.') %>.<%= @title.camelcase.gsub('::', '.') %> extends App.Views.ItemView
    template: '<%= @module.underscore %>/<%= @titletemplate.underscore %>'
