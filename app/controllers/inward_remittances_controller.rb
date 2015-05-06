require 'will_paginate/array'

class InwardRemittancesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def show
    @inward_remittance = InwardRemittance.find_by_id(params[:id])
  end

  def index
    inward_remittances = InwardRemittance.order("id desc")
    @inward_remittances_count = inward_remittances.count
    @inward_remittances = inward_remittances.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def remitter_identities
    inward_remittance = InwardRemittance.find_by_id(params[:id])
    identities = inward_remittance.remitter_identities
    @identities = identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def beneficiary_identities
    inward_remittance = InwardRemittance.find_by_id(params[:id])
    identities = inward_remittance.beneficiary_identities
    @identities = identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end