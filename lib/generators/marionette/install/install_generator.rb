require 'generators/marionette/resource_helpers'

# Install generator
#
# Example:
#
#   rails g marionette:install
class Marionette::InstallGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers

  source_root File.expand_path('../templates', __FILE__)

  def remove_unused_js
    if yes? "Remove turbolinks and requiring tree from application.js? (y)"
      gsub_file "#{javascript_path}/application.js", "//= require turbolink\n", ''
      gsub_file "#{javascript_path}/application.js", "//= require_tree .\n", ''
      gsub_file 'app/views/layouts/application.html.erb', ", 'data-turbolinks-track' => true", ''
    end
  end

  def append_vendor_dependencies
    %w{jquery.spin underscore backbone backbone.marionette backbone-syphon}.each do |lib|
      append_to_file "#{javascript_path}/application.js" do
        "\n//= require #{lib}"
      end
    end
  end

  def append_app_files
    append_to_file "#{javascript_path}/application.js" do
      "\n//= require ./backbone/before_backbone\n" \
        "//= require ./backbone/app\n" \
        "//= require_tree ./backbone/base\n" \
        "//= require_tree ./backbone/config\n" \
        "//= require_tree ./backbone/app/templates\n" \
        "//= require_tree ./backbone/app/views\n" \
        "//= require_tree ./backbone/app/models\n" \
        "//= require_tree ./backbone/app/controllers\n" \
        "//= require ./backbone/routes\n" \
        "//= require ./backbone/after_backbone\n"
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
    generate 'marionette:view', 'layout', 'application'
  end
end
