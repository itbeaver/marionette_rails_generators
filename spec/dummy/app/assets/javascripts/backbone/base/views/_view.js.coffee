@Backbone.app.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  _remove = Marionette.View::remove

  _.extend Marionette.View::,

    addOpacityWrapper: (init = true) ->
      @$el.toggleWrapper
        className: "opacity"
      , init

    setInstancePropertiesFor: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val

    remove: (args...) ->
      console.log "removing", @ if App.environment == 'development'
      if @model?.isDestroyed?()

        wrapper = @$el.toggleWrapper
          className: "opacity"
        # backgroundColor: "#FFECEC"

        wrapper.fadeOut 100, ->
          $(@).remove()

        @$el.fadeOut 100, =>
          _remove.apply @, args
      else
        _remove.apply @, args

    templateHelpers: ->

      linkTo: (name, url, options = {}) ->
        _.defaults options,
          external: false

        url = "#" + url unless options.external

        "<a href='#{url}'>#{@escape(name)}</a>"


      render_partial: ( path, options = {} ) ->
        # add the leading underscore (like rails-partials)
        path = path.split('/')
        path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
        path = path.join('/')
        # render and return the partial if existing
        try
          JST["backbone/app/templates/#{ path }"]( options )
        catch error
          if App.environment != 'production'
            "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"
          else
            console.log('error in _view')
            ''