require 'will_paginate/array'

class ManualPostingsController < ApplicationController
	
  #authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  
  
  def search_record
  	if params[:service_type] == "INW"
  		#@inward_remittances = InwardRemittance.all.order("id desc")
  		@partial_name = "inw_records"
  	elsif params[:service_type] == "ECOLLECT"
  		#@ecol_transactions = EcolTransaction.all.order("id desc")
  		@partial_name = "ecol_records"
  	elsif params[:service_type] == "FUND TRANSFER"
  		#@funds_transfers = FundsTransfer.order("id desc")
  		@partial_name = "ft_records"
  	elsif params[:service_type] == "BULK"
  		@partial_name = "blk_records"	
  	end		
  end

 # def query_block(table_name,transaction_type,multi_value_search,from_date,to_date)
 # 	if table_name == "InwardRemittance"
 # 	elsif table_name == "EcolTransaction"
 # 	elsif table_name == "FundsTransfer"
 # 		multi_value_search = multi_value_search.split(",")

 #    	fund_transfers = FundsTransfer.where("transfer_type=?",transaction_type) if transaction_type.present?
 #    	fund_transfers = FundsTransfer.where("req_timestamp>=? and req_timestamp<=?",Time.zone.parse(from_date).beginning_of_day,Time.zone.parse(to_date).end_of_day) if from_date.present? and to_date.present?
 #    	fund_transfers = FundsTransfer.where("req_no =? OR bank_ref=?  OR cbs_req_ref_no =? OR
 #    										OR status_code =? OR fault_code =? OR fault_reason
 #    										OR customer_id =? OR app_id =?",)
 # 	elsif table_name == "Bulkheaders"
 # 	end		
 # end

end
