@Backbone.app.module "Views.Layouts", (Layouts, App, Backbone, Marionette, $, _) ->

  class Layouts.ApplicationLayout extends App.Views.Layout
    template: 'layouts/application'
    regions:
      bodyRegion: "#body"

  class Layouts.TestLayout1Layout extends App.Views.Layout
    template: 'layouts/test_layout1'
    regions:
      bodyRegion: "#body"

  class Layouts.TestLayout2Layout extends App.Views.Layout
    template: 'layouts/test_layout2'
    regions:
      bodyRegion: "#body"

  class Layouts.TestLayout3Layout extends App.Views.Layout
    template: 'layouts/test_layout3'
    regions:
      bodyRegion: "#body"
