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

  def enable_approve_button?(record)
    record.approval_status == 'U' ? true : false
  end

  def checking_record_for_update(record,params)
    if record.approval_status == 'A'
      params = set_params(record,params)
      new_record = record.class.new
      new_record.attributes = params
      new_record
    else
      record.attributes = params
      record
    end
  end

  def set_params(record,params)
    params[:id] = nil
    params[:lock_version] = record.lock_version
    params[:approved_version] = record.lock_version
    params[:approval_status] = 'U'
    params[:last_action] = 'U'
    params
  end

  def remove_old_records(record,approved_record)
    approved_record.delete unless approved_record.nil?
    record.ecol_unapproved_record.delete unless record.ecol_unapproved_record.nil? 
  end
end