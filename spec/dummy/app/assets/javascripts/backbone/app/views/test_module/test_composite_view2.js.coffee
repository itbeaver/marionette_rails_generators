@Backbone.app.module "Views.TestModule", (TestModule, App, Backbone, Marionette, $, _) ->

  class TestModule.TestCompositeView2 extends App.Views.CollectionView
    template: 'test_module/test_composite_view2'
