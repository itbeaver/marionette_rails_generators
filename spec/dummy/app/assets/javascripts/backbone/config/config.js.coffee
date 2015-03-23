do (Backbone) ->

  _.extend Backbone.Marionette.Application::,

    navigate: (route, options = { trigger: true }) ->
      # route = "#" + route if route.charAt(0) is "/"
      Backbone.history.navigate route, options

    getCurrentRoute: ->
      frag = Backbone.history.fragment
      if _.isEmpty(frag) then null else frag

    startHistory: ->
      if Backbone.history
        Backbone.history.start(
          pushState: true,
          root: "/"
        )

do (Marionette) ->
  _.extend Marionette.Renderer,

    lookups: ["backbone/app/templates/", "backbone/lib/components/"]



    render: (template, data) ->
      return if template is false
      path = @getTemplate(template)
      throw "Template #{template} not found!" unless path
      path(data)

    getTemplate: (template) ->
      for lookup in @lookups
        ## inserts the template at the '-1' position of the template array
        ## this allows to omit the word 'templates' from the view but still
        ## store the templates in a directory outside of the view
        ## example: "users/list/layout" will become "users/list/templates/layout"
        for path in [template, @withTemplate(template)]
          return JST[lookup + path] if JST[lookup + path]

    withTemplate: (string) ->
      array = string.split("/")
      array.splice(-1, 0, "templates")
      array.join("/")

do ($) ->
  $.fn.toggleWrapper = (obj = {}, init = true) ->
    _.defaults obj,
      className: ""
      backgroundColor: if @css("backgroundColor") isnt "transparent" then @css("backgroundColor") else "white"
      zIndex: if @css("zIndex") is "auto" or 0 then 1000 else (Number) @css("zIndex")

    $offset = @offset()
    $width   = @outerWidth(false)
    $height = @outerHeight(false)

    if init
      $("<div>")
        .appendTo("body")
          .addClass(obj.className)
            .attr("data-wrapper", true)
              .css
                width: $width
                height: $height
                top: $offset.top
                left: $offset.left
                position: "absolute"
                zIndex: obj.zIndex + 1
                backgroundColor: obj.backgroundColor
    else
      $("[data-wrapper]").remove()