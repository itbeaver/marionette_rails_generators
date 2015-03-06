@Backbone.app.module "Views.<%= @module.camelcase.gsub('::', '.') %>", (<%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>.<%= @title.camelcase %> extends App.Views.ItemView
    template: '<%= @module.underscore %>/<%= @titletemplate.underscore %>'
