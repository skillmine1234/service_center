class SearchFormBuilder < SimpleForm::FormBuilder
  def standard_fields
    out = ActiveSupport::SafeBuffer.new
    if (object.respond_to? :approval_status)
      if (object.approval_status == 'U')
        out << hidden_field("approval_status", value: object.approval_status)
      else
        out << hidden_field("approval_status", value: 'A')
      end
    end
    out << hidden_field("page", value: 1)
  end
  
  def paginate(records)
    form_id = "'#new_#{object_name}'"
    page_id = "'##{object_name}_page'"
    out = ActiveSupport::SafeBuffer.new
    out << (template.link_to_if records.prev_page, 'Previous', "javascript:$(#{page_id}).val(#{records.prev_page});$(#{form_id}).submit()", class: 'btn btn-primary')
    out << " "
    out << (template.link_to_if records.next_page, 'Next', "javascript:$(#{page_id}).val(#{records.next_page});$(#{form_id}).submit()", class: 'btn btn-primary')
  end

  def cancel(*args)
    button :button, 'Reset', :type => 'reset', :class => 'btn', :id => "adv_search_reset_button"
  end

  def action_buttons
    return if @defaults.present? && @defaults[:show]
    out = ActiveSupport::SafeBuffer.new
    out << submit('Search', :class => "btn btn-primary")
    out << ' '
    out << cancel
    out = "<div class= 'form-actions'>".html_safe + out + '</div>'.html_safe
  end
end