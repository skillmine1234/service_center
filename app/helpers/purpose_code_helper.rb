module PurposeCodeHelper
  # the options for the multi select are stored as a string in the database
  # while in the views we need an array, this helper helps!
  def convert_options_to_array(options_as_string)
    if (!options_as_string.nil?)
      options_as_string.split(',')
    else 
      []
    end
  end

  
  def disallowed_bene_and_rem_types_on_show_page(value)
    if (value == "I,N")
      "Individual,Non-Individual"
    elsif (value == "I")
      "Individual"
    elsif (value == "N")
      "Non-Individual"
    end
  end
  
end