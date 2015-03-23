@Backbone.app.module "Views.TestModule", (TestModule, App, Backbone, Marionette, $, _) ->

  class TestModule.TestCompositeView2 extends App.Views.CompositeView
    template: 'test_module/test_composite_view2'
