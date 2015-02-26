@Backbone.app.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.<%= @title.capitalize %> extends App.Controllers.Application
    initialize: (args={}) ->
      args.action = '' unless args.action
      switch args.action
      <%- @actions.each do |a| -%>
        when '<%= a %>'
          console.log '<%= a %> action is fired!'
      <%- end -%>
        else
          console.log('Not found')
