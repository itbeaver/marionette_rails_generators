require 'generators/marionette/resource_helpers'

# Install generator
#
# Example:
#
#   rails g marionette:install
class Marionette::InstallGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers

  source_root File.expand_path('../templates', __FILE__)

  def append_vendor_dependencies
    inject_into_file "#{javascript_path}/application.js", before: "//= require_tree ." do %(
//= require jquery.spin
//= require underscore
//= require backbone
//= require backbone.marionette
//= require backbone-syphon

)
    end
  end

  def append_app_files
    inject_into_file "#{javascript_path}/application.js", before: "\n//= require_tree ." do %(
//= require ./backbone/before_backbone
//= require ./backbone/app
//= require_tree ./backbone/base
//= require_tree ./backbone/config
//= require_tree ./backbone/app/templates
//= require_tree ./backbone/app/views
//= require_tree ./backbone/app/models
//= require_tree ./backbone/app/controllers
//= require ./backbone/routes
//= require ./backbone/after_backbone
)
    end
  end

  def create_dir_layout
    empty_directory "#{javascript_path}/backbone"
    %w(base config app).each { |dir| empty_directory "#{javascript_path}/backbone/#{dir}" }
    %w(controllers models views).each { |dir| empty_directory "#{javascript_path}/backbone/base/#{dir}" }
    %w(controllers models views).each { |dir| empty_directory "#{javascript_path}/backbone/config/#{dir}" }
    %w(templates views models controllers).each { |dir| empty_directory "#{javascript_path}/backbone/app/#{dir}" }
  end

  def create_app_file
    template 'app.js.coffee', "#{javascript_path}/backbone/app.js.coffee"
    template 'after_backbone.js.coffee', "#{javascript_path}/backbone/after_backbone.js.coffee"
    template 'before_backbone.js.coffee', "#{javascript_path}/backbone/before_backbone.js.coffee"
    template 'routes.js.coffee', "#{javascript_path}/backbone/routes.js.coffee"
  end

  def start_marionette_app
    destination = "app/views/#{default_controller}/#{default_action}.html.erb"
    create_file destination unless File.exist? destination
    append_to_file destination do
      embed_template 'index.html.erb'
    end
  end

  def copy_base
    directory 'base', "#{javascript_path}/backbone/base/"
  end

  def copy_config
    directory 'config', "#{javascript_path}/backbone/config/"
  end

  def add_routes
    route "root '#{default_route}'"
    route "get '*path' => '#{default_route}'"
  end

  def generate_application_layout
    generate 'marionette:view', 'application', 'Layout'
    generate 'marionette:controller root index --with-views'
    if File.exist? "#{javascript_path}/backbone/routes.js.coffee"
      inject_into_file "#{javascript_path}/backbone/routes.js.coffee", after: "console.log 'Hello world!'\n" do <<-'COFFEE'
      new App.Controllers.All.Root(action: 'index')
      COFFEE
      end
    end
    template 'app/templates/index.jst.eco', "#{javascript_path}/backbone/app/templates/root/index.jst.eco", force: true
  end
end
