@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.CollectionView extends Marionette.CollectionView
    childViewEventPrefix: "childview"