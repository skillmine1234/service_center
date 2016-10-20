require 'will_paginate/array'

class ScUnapprovedRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include ScUnapprovedRecordsHelper

  def index
    records = filter_records(ScUnapprovedRecord,params)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end
