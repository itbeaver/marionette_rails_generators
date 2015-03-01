@Backbone.app.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.<%= @title.camelcase %> extends App.Controllers.Application
    initialize: (args={}) ->
      args.action = '' unless args.action
      switch args.action
      <%- @actions.each do |a| -%>
        when '<%= a %>'
          @layout = new App.Views.ApplicationLayout
          @listenTo @layout, "show", =>
            <%= a %>View = new App.Views.<%= @title.camelcase %>.Index
            @show <%= a %>View, region: @layout.bodyRegion
          @show @layout
      <%- end -%>
        else
          console.log('Not found')
