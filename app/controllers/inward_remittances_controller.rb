require 'will_paginate/array'

class InwardRemittancesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include InwardRemittanceHelper

  def show
    @inward_remittance = InwardRemittance.find_by_id(params[:id])
  end

  def index
    inward_remittances = InwardRemittance.order("id desc")
    if params[:req_no]
      inward_remittances = inward_remittances.where(:req_no => params[:req_no]).order("id desc") 
    else
      maxQuery = InwardRemittance.select("max(attempt_no) as attempt_no,req_no").group(:req_no)      
      inward_remittances = InwardRemittance.joins("inner join (#{maxQuery.to_sql}) a on a.req_no=inward_remittances.req_no and a.attempt_no=inward_remittances.attempt_no").order("inward_remittances.id DESC")
    end
    inward_remittances = find_inward_remittances(inward_remittances,params) if params[:advanced_search].present?
    @inward_remittances_count = inward_remittances.count
    @inward_remittances = inward_remittances.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  # to reuse the view
  def identity
    inw_txn = InwardRemittance.find(params[:id])
    @identities = InwIdentity.where(id: params[:id_id]).paginate(:per_page => 10, :page => params[:page]) rescue []
    render '_identities'
  end

  def remitter_identities
    @user = current_user
    inward_remittance = InwardRemittance.find_by_id(params[:id])
    identities = inward_remittance.remitter_identities
    @identities = identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def beneficiary_identities
    @user = current_user
    inward_remittance = InwardRemittance.find_by_id(params[:id])
    identities = inward_remittance.beneficiary_identities
    @identities = identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @inward_remittance = InwardRemittance.find(params[:id])
    values = find_logs(params, @inward_remittance)
    @values_count = values.count(:id)
    @values = values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  private

  def inward_remittance_params
    params.require(:inward_remittance).permit(:attempt_no, :bank_ref, :bene_account_ifsc, :bene_account_no, :bene_address1, 
                  :bene_address2, :bene_address3, :bene_city, :bene_country, :bene_email_id, 
                  :bene_first_name, :bene_full_name, :bene_identity_count, :bene_last_name, 
                  :bene_mobile_no, :bene_postal_code, :bene_ref, :bene_state, :partner_code, 
                  :purpose_code, :rep_no, :rep_timestamp, :rep_version, :req_no, :req_timestamp, 
                  :req_version, :review_pending, :review_reqd, :rmtr_address1, :rmtr_address2, 
                  :rmtr_address3, :rmtr_city, :rmtr_country, :rmtr_email_id, :rmtr_first_name, 
                  :rmtr_full_name, :rmtr_identity_count, :rmtr_last_name, :rmtr_mobile_no, 
                  :rmtr_postal_code, :rmtr_state, :rmtr_to_bene_note, :status_code, 
                  :transfer_amount, :transfer_ccy, :transfer_type)
  end
end