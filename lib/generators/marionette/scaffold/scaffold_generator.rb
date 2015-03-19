require 'generators/marionette/resource_helpers'

# Scaffold generator
#
# Example:
#
class Marionette::ScaffoldGenerator < Rails::Generators::Base
  include Marionette::ResourceHelpers
  desc %(
    pending
  )

  source_root File.expand_path('../templates', __FILE__)

  argument :title, type: :string, required: true, banner: 'Entity'
  argument :schema, type: :hash, default: {}, banner: 'title:string description:text'

  def vars
    @module = 'All'
    if @title =~ /\//
      parse = @title.match /(.*)\/(.*)/
      @title = parse[2]
      @module = parse[1]
    end
    @one = @title.singularize
    @many = @title.pluralize
  end

  def scaffold
    generate "marionette:model #{@one.camelcase} #{@schema.map {|a| "#{a[0]}:#{a[1]}"}.join(' ')}"

    generate "marionette:view #{@many.underscore}/_empty ItemView"
    template 'templates/_empty.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/_empty.jst.eco", force: true
    generate "marionette:view #{@many.underscore}/_post ItemView"
    template 'templates/_post.jst.eco', "#{backbone_path}/app/templates/#{@many.underscore}/_post.jst.eco", force: true
  end
end
