@Backbone.app.module "Entities.Admin", (Admin, App, Backbone, Marionette, $, _) ->

  class Admin.Books extends App.Entities.Model
    urlRoot: -> '/api/books'
    schema:
      {
      }

  class Admin.BooksCollection extends App.Entities.Collection
    model: Admin.Books
    url: -> '/api/books'
