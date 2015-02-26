@Backbone.app.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.<%= @title.capitalize %> extends App.Entities.Model
    urlRoot: -> '/api/<%= @title.underscore %>'
    schema:
      {
      <%- @schema.each_with_index do |val, i| -%>
        <%= val[0] %>: '<%= val[1] %>'<%= (i == @schema.size - 1) ? '' : ',' %>
      <%- end -%>
      }

  class Entities.<%= @title.capitalize %>Collection extends App.Entities.Collection
    model: Entities.<%= @title.capitalize %>
    url: -> '/api/<%= @title.underscore %>'
