module SuIncomingRecordsHelper
  def find_logs(params,transaction)
    if params[:step_name] != 'ALL'
      transaction.su_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      transaction.su_audit_steps.order("id desc") rescue []
    end      
  end

  def find_su_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("corp_account_no=?",params[:corp_account_no]) if params[:corp_account_no].present?
    incoming_records = incoming_records.where("emp_account_no=?",params[:emp_account_no]) if params[:emp_account_no].present?
    incoming_records = incoming_records.where("emp_name=?",params[:emp_name]) if params[:emp_name].present?
    incoming_records = incoming_records.where("salary_amount>=? and salary_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    incoming_records
  end
end
