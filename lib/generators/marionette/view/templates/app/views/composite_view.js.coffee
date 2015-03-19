@Backbone.app.module "Views.<%= @module.split('/').map{ |v| v.camelcase }.join('.') %>", (<%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>.<%= @title.camelcase %> extends App.Views.CompositeView
    template: '<%= @module.underscore %>/<%= @titletemplate.underscore %>'
