module SuIncomingRecordsHelper
  def find_logs(params,record)
    if params[:step_name] != 'ALL'
      record.fm_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      record.fm_audit_steps.order("id desc") rescue []
    end      
  end

  def find_su_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("should_skip=?",params[:skipped_flag]) if params[:skipped_flag].present?
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("su_incoming_records.corp_account_no=?",params[:corp_account_no]) if params[:corp_account_no].present?
    incoming_records = incoming_records.where("su_incoming_records.emp_account_no=?",params[:emp_account_no]) if params[:emp_account_no].present?
    incoming_records = incoming_records.where("su_incoming_records.emp_name=?",params[:emp_name]) if params[:emp_name].present?
    incoming_records = incoming_records.where("su_incoming_records.salary_amount>=? and su_incoming_records.salary_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    incoming_records
  end

  def check_records(records,params)
    if params[:status] == "skip"
      records.select{|record| record.incoming_file_record.should_skip == 'Y' or record.incoming_file_record.status != 'FAILED'}
    else
      records.select{|record| record.incoming_file_record.should_skip == 'Y' or record.incoming_file_record.status != 'FAILED' or !record.incoming_file_record.fault_code.start_with?("ns:W")}      
    end
  end

  def skip_records(records,params)
    records.each do |record|
      record.incoming_file_record.update_attributes(:should_skip => "Y")
    end
  end

  def override_records(records,params)
    records.each do |record|
      record.incoming_file_record.update_attributes(:overrides => record.incoming_file_record.fault_code)
    end
  end
end
