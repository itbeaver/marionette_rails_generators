@Backbone.app.module "Entities.<%= @module.split('/').map{ |v| v.camelcase }.join('.') %>", (<%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>.<%= @title.camelcase %> extends App.Entities.Model
    urlRoot: -> '/api/<%= @title.underscore %>'
    schema:
      {
      <%- @schema.each_with_index do |val, i| -%>
        <%= val[0] %>: '<%= val[1] %>'<%= (i == @schema.size - 1) ? '' : ',' %>
      <%- end -%>
      }

  class <%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>.<%= @title.camelcase %>Collection extends App.Entities.Collection
    model: <%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>.<%= @title.camelcase %>
    url: -> '/api/<%= @title.underscore %>'
