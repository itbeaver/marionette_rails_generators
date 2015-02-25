require 'generators/marionette/resource_helpers'

# Layout generator
#
# Example:
#
#   rails g marionette:generate:layout application
class Marionette::LayoutGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc 'Creates layout view and layout template'

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string

  def generate_view
    @title = title
    template 'app/views/layouts/layouts.js.coffee',
             "#{javascript_path}/backbone/app/views/layouts/layouts.js.coffee"
  end

  def generate_template
    template 'app/templates/layouts/application.jst.eco',
             "#{javascript_path}/backbone/app/templates/layouts/#{title}.jst.eco"
  end
end
