class YesnoInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options)
    input_html_options.merge!({required: false, 'aria-required': false})
    input_html_options[:class].delete(:required)
    super
  end  

  # TODO: how to change the label to optional
  def label(wrapper_options)
    super
  end  

  def checked_value
    'Y'
  end

  def unchecked_value
    'N'
  end
end