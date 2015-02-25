<% if !@module.blank? %>
  @Backbone.app.module "Views.<%= @module.capitalize %>", (<%= @module.capitalize %>, App, Backbone, Marionette, $, _) ->

    class <%= @module.capitalize %>.<%= title.capitalize %> extends App.Views.ItemView
      template: '<%= title.underscore %>'

<% else %>
  @Backbone.app.module "Views.All", (All, App, Backbone, Marionette, $, _) ->

    class All.<%= title.capitalize %> extends App.Views.ItemView
      template: '<%= title.underscore %>'

<% end %>