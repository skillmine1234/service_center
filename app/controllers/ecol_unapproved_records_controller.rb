require 'will_paginate/array'

class EcolUnapprovedRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def index
    if params[:advanced_search] == "true"
      records = EcolUnapprovedRecord.order("id desc")
      records = records.where("unique_value =?",params[:record_value]) if params[:record_value].present?
      records = records.where("ecol_approvable_type =?",params[:record_type]) if params[:record_type].present?
      @records_count = records.count
      @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
    end
  end
end

