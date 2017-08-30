module ApplicationHelper
  def error_message_for(resource, field, options = {:prepend_text => ""})
    error_message = resource.errors[field][0] rescue nil
    if error_message
      raw "#{options[:prepend_text]} #{error_message}"
    end
  end

  def version_ids(resource)
    version_array = []
    version = resource.audits.count
    while version >= 1
      version = version - 1
      version_array << ["Version " + version.to_s, version]
    end
    version_array
  end

  def old_values(values)
    if values.is_a?(Array)
      values[0] rescue nil
    else
      nil
    end
  end

  def new_values(values)
    if values.is_a?(Array)
      values[1] rescue nil
    else
      values
    end
  end

  def audit_count(resource)
    count = resource.audits.count
    count > 0 ? count - 1 : 0
  end 

  def has_route? options
    Rails.application.routes.routes.map{|route| route.defaults}.include?(options)
  end

  def valid_date(date)
    d = Date.strptime(date, '%d-%m-%Y') rescue false
    d != false ? true : false
  end

  def advanced_search_page_links
    capture do
      concat link_to_if @records.previous_page, 'Previous', "javascript:$('#page').val(#{@records.previous_page});$('#advanced_search').submit()"
      concat " "
      concat link_to_if @records.next_page, 'Next', "javascript:$('#page').val(#{@records.next_page});$('#advanced_search').submit()"
    end
  end
  
  def relative_time(timestamp)
    timestamp.present? ? time_ago_in_words(timestamp)+' ago' : '-'
  end
  
  def show_xml(link,class_name,request)
    link_to_unless((current_user.has_role? :customer), link, '#',{:class => class_name, :href => "javascript:void()", data: { request: request, reply: request }})
  end
end