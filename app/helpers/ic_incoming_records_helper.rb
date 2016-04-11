module IcIncomingRecordsHelper
  def find_ic_logs(params,record)
    if params[:step_name] != 'ALL'
      record.ic_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      record.ic_audit_steps.order("id desc") rescue []
    end      
  end

  def find_ic_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("should_skip=?",params[:skipped_flag]) if params[:skipped_flag].present?
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("ic_incoming_records.supplier_code=?",params[:supplier_code]) if params[:supplier_code].present?
    incoming_records = incoming_records.where("ic_incoming_records.invoice_no=?",params[:invoice_no]) if params[:invoice_no].present?
    incoming_records = incoming_records.where("ic_incoming_records.invoice_amount>=? and ic_incoming_records.invoice_amount<=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    incoming_records = incoming_records.where("ic_incoming_records.invoice_date>=? and ic_incoming_records.invoice_date<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    incoming_records = incoming_records.where("ic_incoming_records.debit_ref_no=?",params[:debit_ref_no]) if params[:debit_ref_no].present?
    incoming_records
  end
end
