module RcTransfersHelper
  def find_logs(params,record)
    if params[:step_name] != 'ALL'
      record.rc_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      record.rc_audit_steps.order("id desc") rescue []
    end      
  end
end
