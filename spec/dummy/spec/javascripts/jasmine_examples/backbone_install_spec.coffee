describe 'Backbone app after install', ->
  describe 'vendor', ->
    it 'Backbone responds', ->
      expect(Backbone).toBeDefined()

    it 'Marionette responds', ->
      expect(Marionette).toBeDefined()

    it 'syphon responds', ->
      expect(Backbone.Syphon).toBeDefined()

  it 'app responds', ->
    expect(Backbone.app).toBeDefined()

  it 'app router responds', ->
    expect(Backbone.app.Router).toBeDefined()

  it 'main layout responds', ->
    expect(Backbone.app.Views.ApplicationLayout).toBeDefined()
    layout = new Backbone.app.Views.ApplicationLayout
    expect(layout).toEqual(jasmine.any(Backbone.app.Views.ApplicationLayout))

  it 'root#index view responds', ->
    expect(Backbone.app.Views.Root.Index).toBeDefined()
    indexView = new Backbone.app.Views.Root.Index
    expect(indexView).toEqual(jasmine.any(Backbone.app.Views.Root.Index))

  it 'root controller responds', ->
    expect(Backbone.app.Controllers.Root).toBeDefined()
    controller = new Backbone.app.Controllers.Root
    expect(controller).toEqual(jasmine.any(Backbone.app.Controllers.Root))

  describe 'Base', ->
    describe 'controllers', ->
      it 'base controller responds', ->
        expect(Backbone.app.Controllers.Application).toBeDefined()
        controller = new Backbone.app.Controllers.Application
        expect(controller).toEqual(jasmine.any Backbone.app.Controllers.Application)

    describe 'entities', ->
      it 'base entity conllection responds', ->
        expect(Backbone.app.Entities.Collection).toBeDefined()
        collection = new Backbone.app.Entities.Collection
        expect(collection).toEqual(jasmine.any Backbone.app.Entities.Collection)

      it 'base entity model responds', ->
        expect(Backbone.app.Entities.Model).toBeDefined()
        entity = new Backbone.app.Entities.Model
        expect(entity).toEqual(jasmine.any Backbone.app.Entities.Model)

    describe 'views', ->
      it 'base layout responds', ->
        expect(Backbone.app.Views.Layout).toBeDefined()
        layout = new Backbone.app.Views.Layout
        expect(layout).toEqual(jasmine.any Backbone.app.Views.Layout)

      it 'base itemview responds', ->
        expect(Backbone.app.Views.ItemView).toBeDefined()
        itemview = new Backbone.app.Views.ItemView
        expect(itemview).toEqual(jasmine.any Backbone.app.Views.ItemView)

      it 'base collectionview responds', ->
        expect(Backbone.app.Views.CollectionView).toBeDefined()
        collectionview = new Backbone.app.Views.CollectionView
        expect(collectionview).toEqual(jasmine.any Backbone.app.Views.CollectionView)

      it 'base compositeview responds', ->
        expect(Backbone.app.Views.CompositeView).toBeDefined()
        compositeview = new Backbone.app.Views.CompositeView
        expect(compositeview).toEqual(jasmine.any Backbone.app.Views.CompositeView)

  describe 'Utilites', ->

    it 'Loading controller responds', ->
      expect(Backbone.app.Utilites.Loading.LoadingController).toBeDefined()

    it 'Loading view responds', ->
      expect(Backbone.app.Utilites.Loading.LoadingView).toBeDefined()
      loadingview = new Backbone.app.Utilites.Loading.LoadingView
      expect(loadingview).toEqual(jasmine.any Backbone.app.Utilites.Loading.LoadingView)

