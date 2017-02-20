require 'will_paginate/array'

class RrUnapprovedRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include RrUnapprovedRecordsHelper

  def index
    records = filter_records(RrUnapprovedRecord)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end
