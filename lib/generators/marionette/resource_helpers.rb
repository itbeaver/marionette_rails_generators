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

    def module_name_class
      file_name.camelize + 'App'
    end

    def module_name_underscore
      file_name.underscore
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
  end
end
