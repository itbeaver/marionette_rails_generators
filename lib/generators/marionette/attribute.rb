
# :nodoc:
class Marionette::Attribute
  include ActionView::Helpers::FormTagHelper
  include ActionView::Context
  attr_accessor :column_name, :type, :field_type

  def initialize(name, type=nil)
    @column_name    = name
    @type           = type || :string
  end

  def password_digest?
    @column_name == 'password' && @type == 'digest'
  end

  def label_html
    label_tag(column_name.to_sym)
  end

  def input_html
    eval("#{self.field_type}_tag(:#{self.column_name})")
  end

  def wrapper(&block)
    output = "<div class=\"field\">\n".html_safe
    output << capture(&block)
    output.safe_concat("\n  </div>")
  end

  def html
    capture do
      wrapper = self.wrapper do
        concat((' '*4 + label_html).html_safe)
        concat "\n"
        concat((' '*4 + input_html).html_safe)
      end
    end
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
