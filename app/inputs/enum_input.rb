class EnumInput < SimpleForm::Inputs::CollectionSelectInput      
  def collection
    template.enum_option_pairs(object, attribute_name)
  end
end
