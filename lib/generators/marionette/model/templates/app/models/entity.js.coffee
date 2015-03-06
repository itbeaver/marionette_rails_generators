@Backbone.app.module "Entities.<%= @module.camelcase.gsub('::', '.') %>", (<%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>.<%= @title.camelcase %> extends App.Entities.Model
    urlRoot: -> '/api/<%= @title.underscore %>'
    schema:
      {
      <%- @schema.each_with_index do |val, i| -%>
        <%= val[0] %>: '<%= val[1] %>'<%= (i == @schema.size - 1) ? '' : ',' %>
      <%- end -%>
      }

  class <%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>.<%= @title.camelcase %>Collection extends App.Entities.Collection
    model: <%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>.<%= @title.camelcase %>
    url: -> '/api/<%= @title.underscore %>'
