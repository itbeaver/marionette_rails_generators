@Backbone.app.module "Controllers.<%= @module.split('/').map{ |v| v.camelcase }.join('.') %>", (<%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>, App, Backbone, Marionette, $, _) ->

  class <%= @module.split('/').map{ |v| v.camelcase }.last.to_s %>.<%= @title.camelcase %> extends App.Controllers.Application
    initialize: (args={}) ->
      args.action = '' unless args.action
      switch args.action
      <%- @actions.each do |a| -%>
        when '<%= a %>'
          console.log '<%= a %> action is fired!'
      <%- end -%>
        else
          console.log('Not found')
