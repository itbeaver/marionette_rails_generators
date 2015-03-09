
# :nodoc:
class Marionette::Attribute < Rails::Generators::Base
  attr_accessor :column_name, :type, :field_type

  def initialize(name, type=nil)
    @column_name    = name
    @type           = type || :string
  end

  def password_digest?
    column_name == 'password' && type == :digest
  end

  def field_type
    @field_type ||= case @type
      when 'integer'              then :number_field
      when 'float', 'decimal'      then :text_field
      when 'time'                 then :time_select
      when 'datetime', 'timestamp' then :datetime_select
      when 'date'                 then :date_select
      when 'text'                 then :text_area
      when 'boolean'              then :check_box
      else
        :text_field
    end
  end
end
