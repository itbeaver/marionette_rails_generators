@Backbone.app.module "Entities.All", (All, App, Backbone, Marionette, $, _) ->

  class All.Posts extends App.Entities.Model
    urlRoot: -> '/api/posts'
    schema:
      {
        title: 'string',
        description: 'text'
      }

  class All.PostsCollection extends App.Entities.Collection
    model: All.Posts
    url: -> '/api/posts'
