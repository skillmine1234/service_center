module Cnb2IncomingRecordsHelper
  def find_cnb2_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("cnb2_incoming_records.vendor_code=?",params[:vendor_code]) if params[:vendor_code].present?
    incoming_records = incoming_records.where("cnb2_incoming_records.bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    incoming_records = incoming_records.where("cnb2_incoming_records.amount >=?",params[:from_amount].to_f) if params[:from_amount].present?
    incoming_records = incoming_records.where("cnb2_incoming_records.amount <=?",params[:to_amount].to_f) if params[:to_amount].present? 
    incoming_records
  end
end