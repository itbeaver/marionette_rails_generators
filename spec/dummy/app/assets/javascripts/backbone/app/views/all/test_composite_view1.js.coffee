@Backbone.app.module "Views.All", (All, App, Backbone, Marionette, $, _) ->

  class All.TestCompositeView1 extends App.Views.CollectionView
    template: 'all/test_composite_view1'
