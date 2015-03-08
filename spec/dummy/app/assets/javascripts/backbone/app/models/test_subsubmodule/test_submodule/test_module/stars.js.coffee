@Backbone.app.module "Entities.TestSubsubmodule.TestSubmodule.TestModule", (TestModule, App, Backbone, Marionette, $, _) ->

  class TestModule.Stars extends App.Entities.Model
    urlRoot: -> '/api/stars'
    schema:
      {
      }

  class TestModule.StarsCollection extends App.Entities.Collection
    model: TestModule.Stars
    url: -> '/api/stars'
