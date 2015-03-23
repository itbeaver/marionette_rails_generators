@Backbone.app.module "Views.Root", (Root, App, Backbone, Marionette, $, _) ->

  class Root.Index extends App.Views.ItemView
    template: 'root/index'



