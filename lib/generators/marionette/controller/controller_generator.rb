require 'generators/marionette/resource_helpers'

# :nodoc:
class Marionette::ControllerGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(Description:
    Stubs out a new controller. Pass the controller name, either
    CamelCased or under_scored, and a optional list of views as arguments.

    To create a controller within a module, specify the controller name as a
    path like 'parent_module/controller_name'.

    This generates a controller class in
      app/assets/javascripts/backbone/app/controllers/
    and invokes view generator if --with-views options is passed.

Example:
    `rails generate marionette:controller CreditCards open debit credit close --with-views`

    CreditCardsController with URLs like /credit_cards/debit at app/assets/javascripts/backbone/
        Controller: .../app/controllers/all/credit_cards_controller.js.coffee
        View:       .../app/views/all/credit_cards/debit.js.coffee
        Template:   .../app/templates/all/credit_cards/debit.js.eco
)

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, banner: "Title",
                             desc: "controller title"
  argument :actions, type: :array, banner: "ACTION ACTION", default: ['index', 'new', 'show', 'edit'],
                             desc: "actions for the resource controller"
  class_option :with_views, type: :boolean, default: false,
                             desc: "generate with views"

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
  end

  def generate_view
    @with_views = options[:with_views]
    if @with_views
      template 'app/controllers/controller_with_views.js.coffee',
               "#{backbone_path}/app/controllers/#{@module.underscore}/#{@title.underscore}_controller.js.coffee"
      @actions.each do |act|
        generate 'marionette:view', "#{@title}/#{act}", 'ItemView'
      end
    else
      template 'app/controllers/controller.js.coffee',
             "#{backbone_path}/app/controllers/#{@module.underscore}/#{@title.underscore}_controller.js.coffee"
    end
  end
end
