@Backbone.app.module "Controllers.<%= @module.camelcase.gsub('::', '.') %>", (<%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.camelcase.gsub('::', '.').split('.').last.to_s %>.<%= @title.camelcase.gsub('::', '.') %> extends App.Controllers.Application
    initialize: (args={}) ->
      args.action = '' unless args.action
      switch args.action
      <%- @actions.each do |a| -%>
        when '<%= a %>'
          console.log '<%= a %> action is fired!'
      <%- end -%>
        else
          console.log('Not found')
