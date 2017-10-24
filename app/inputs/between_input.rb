class BetweenInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    
    from_field = :"from_#{attribute_name}"
    to_field = :"to_#{attribute_name}"
    field_type = object.klass.columns_hash[attribute_name.to_s].type

    def input_html_options
      super.merge({class: 'between_input'})
    end

    if [:integer, :decimal, :float].include?(field_type)
      field1 = @builder.number_field(from_field, input_html_options)
      field2 = @builder.number_field(to_field, input_html_options)
    elsif [:date, :time, :datetime].include?(field_type)
      # searcher is an activemodel and does not have a data-type 
      # to set values to date/time fields, strings have to be coerced to datetimes
      object.send("#{from_field}=",  object.send(from_field).try(:to_datetime))
      object.send("#{to_field}=",  object.send(to_field).try(:to_datetime))
      
      field1 = @builder.datetime_field(from_field, input_html_options)
      field2 = @builder.datetime_field(to_field, input_html_options)
    else
      field1 = @builder.text_field(from_field, input_html_options)
      field2 = @builder.text_field(to_field, input_html_options)
    end
    
    # Be aware for I18n: translate the "and" here
    (field1 << @builder.label(from_field, ' To ', class: 'separator control-label text-center') << field2).html_safe
  end

  # Make the label be for the first of the two fields
  def label_target
    :"to_#{attribute_name}"
  end
end

