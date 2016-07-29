require 'will_paginate/array'

class PcProgramsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PcProgramsHelper

  def new
    @pc_program = PcProgram.new
  end

  def create
    @pc_program = PcProgram.new(params[:pc_program])
    if !@pc_program.valid?
      render "new"
    else
      @pc_program.created_by = current_user.id
      @pc_program.save!
      flash[:alert] = 'PcProgram successfully created and is pending for approval'
      redirect_to @pc_program
    end
  end 

  def edit
    pc_program = PcProgram.unscoped.find_by_id(params[:id])
    if pc_program.approval_status == 'A' && pc_program.unapproved_record.nil?
      params = (pc_program.attributes).merge({:approved_id => pc_program.id,:approved_version => pc_program.lock_version})
      pc_program = PcProgram.new(params)
    end
    @pc_program = pc_program  
  end

  def update
    @pc_program = PcProgram.unscoped.find_by_id(params[:id])
    @pc_program.attributes = params[:pc_program]
    if !@pc_program.valid?
      render "edit"
    else
      @pc_program.updated_by = current_user.id
      @pc_program.save!
      flash[:alert] = 'PcProgram successfully modified and is pending for approval'
      redirect_to @pc_program
    end
    rescue ActiveRecord::StaleObjectError
      @pc_program.reload
      flash[:alert] = 'Someone edited the pc_program the same time you did. Please re-apply your changes to the pc_program.'
      render "edit"
  end 

  def show
    @pc_program = PcProgram.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc_programs = find_pc_programs(params).order("id desc")
    else
      pc_programs = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcProgram.unscoped.where("approval_status =?",'U').order("id desc") : PcProgram.order("id desc")
    end
    @pc_programs_count = pc_programs.count
    @pc_programs = pc_programs.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @pc_program = PcProgram.unscoped.find(params[:id]) rescue nil
    @audit = @pc_program.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc_program = PcProgram.unscoped.find(params[:id]) rescue nil
    PcProgram.transaction do
      approval = @pc_program.approve
      if @pc_program.save and approval.empty?
        flash[:alert] = "PcProgram record was approved successfully"
      else
        msg = approval.empty? ? @pc_program.errors.full_messages : @pc_program.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc_program
  end

  private

  def pc_program_params
    params.require(:pc_program).permit(:code, :is_enabled, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password, 
                                       :created_by, :updated_by, :lock_version, :approval_status, :last_action, :approved_version, :approved_id)
  end
end
