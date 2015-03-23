@Backbone.app.module "Views.Admin", (Admin, App, Backbone, Marionette, $, _) ->

  class Admin.TestCollectionView2 extends App.Views.CollectionView
    template: 'admin/test_collection_view2'
