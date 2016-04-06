require 'will_paginate/array'

class Pc2UnapprovedRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Pc2UnapprovedRecordsHelper

  def index
    records = filter_records(Pc2UnapprovedRecord)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end
