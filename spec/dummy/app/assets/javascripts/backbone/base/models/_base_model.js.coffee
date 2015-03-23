@Backbone.app.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"

    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true
        success:   _.bind(@saveSuccess, @, isNew, options.collection)
        error:    _.bind(@saveError, @)

      @unset "_errors"
      super data, options

    saveSuccess: (isNew, collection) =>
      if isNew
        collection?.add @
        collection?.trigger "model:created", @
        @trigger "created", @
      else
        collection ?= @collection
        ## if model has collection property defined,
        ## use that if no collection option exists
        collection?.trigger "model:updated", @
        @trigger "updated", @

    saveError: (model, xhr, options) =>
      unless xhr.status is 500 or xhr.status is 404
        @set _errors: $.parseJSON(xhr.responseText)?.errors