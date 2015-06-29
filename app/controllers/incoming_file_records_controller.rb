require 'will_paginate/array'

class IncomingFileRecordsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html

  def index
    records = IncomingFileRecord.where("incoming_file_id =?",params[:incoming_file_id]).order("id desc")
    @records_count = records.count
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end