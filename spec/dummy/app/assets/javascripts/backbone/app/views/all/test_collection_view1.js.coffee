@Backbone.app.module "Views.All", (All, App, Backbone, Marionette, $, _) ->

  class All.TestCollectionView1 extends App.Views.CollectionView
    template: 'all/test_collection_view1'
