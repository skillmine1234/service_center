module FpOperationsHelper
  def find_fp_operations(params)
    fp_operations = (params[:approval_status].present? and params[:approval_status] == 'U') ? FpOperation.unscoped : FpOperation
    fp_operations = fp_operations.where("operation_name=?",params[:operation_name]) if params[:operation_name].present?
    fp_operations
  end
end
