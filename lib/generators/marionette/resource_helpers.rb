module Marionette
  # Resource helpers
  module ResourceHelpers
    def javascript_path
      'app/assets/javascripts'
    end

    def backbone_path
      "#{javascript_path}/backbone"
    end

    def default_action
      'index'
    end

    def default_controller
      'application'
    end

    def default_route
      "#{default_controller}##{default_action}"
    end

    def embed_file(source, indent = '')
      IO.read(File.join(self.class.source_root, source)).gsub(/^/, indent)
    end

    def embed_template(source, indent = '')
      template = File.join(self.class.source_root, source)
      ERB.new(IO.read(template), nil, '-').result(binding).gsub(/^/, indent)
    end

    def replace_underscore(string)
      string[0] == '_' ? string[1..-1] : string
    end

    def view_attr(file, attrs)
      sentinel = /extends.*$/
      in_root do
        inject_into_file "#{backbone_path}/app/views/#{file}.js.coffee", "\n#{attrs}", { after: sentinel, verbose: false }
      end
    end

    def marionette_route(routing_code, type, modul='All')
      log :marionette_route, routing_code
      sentinel = /appRoutes\:\s*$/

      route = routing_code

      case type
      when :index
        route = "    \"#{routing_code}(/)\": \"#{routing_code}_index\""
      when :new
        route = "    \"#{routing_code}/new(/)\": \"#{routing_code}_new\""
      when :show
        route = "    \"#{routing_code}/:id(/)\": \"#{routing_code}_show\""
      when :edit
        route = "    \"#{routing_code}/:id/edit(/)\": \"#{routing_code}_edit\""
      end

      in_root do
        inject_into_file "#{backbone_path}/routes.js.coffee", "\n  #{route}", { after: sentinel, verbose: false }
      end


      case type
      when :index
        api = %(
    #{routing_code}_index: ->
      new App.Controllers.#{modul}.#{routing_code.camelize}(action: 'index')
)
      when :new
        api = %(
    #{routing_code}_new: ->
      new App.Controllers.#{modul}.#{routing_code.camelize}(action: 'new')
)
      when :show
        api = %(
    #{routing_code}_show: (id) ->
      new App.Controllers.#{modul}.#{routing_code.camelize}(id: id, action: 'show')
)
      when :edit
        api = %(
    #{routing_code}_edit: (id) ->
      new App.Controllers.#{modul}.#{routing_code.camelize}(id: id, action: 'edit')
)
      end

      sentinel = /API \=\s*$/

      in_root do
        inject_into_file "#{backbone_path}/routes.js.coffee", "\n#{api}", { after: sentinel, verbose: false }
      end
    end
  end
end
