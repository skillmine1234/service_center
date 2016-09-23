require 'will_paginate/array'

class PcProductsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PcProductsHelper

  def new
    @pc_product = PcProduct.new
  end

  def create
    @pc_product = PcProduct.new(params[:pc_product])
    if !@pc_product.valid?
      render "new"
    else
      @pc_product.created_by = current_user.id
      @pc_product.save!
      flash[:alert] = 'PcProduct successfully created and is pending for approval'
      redirect_to @pc_product
    end
  end 

  def edit
    pc_product = PcProduct.unscoped.find_by_id(params[:id])
    if pc_product.approval_status == 'A' && pc_product.unapproved_record.nil?
      params = (pc_product.attributes).merge({:approved_id => pc_product.id,:approved_version => pc_product.lock_version})
      pc_product = PcProduct.new(params)
    end
    @pc_product = pc_product  
  end

  def update
    @pc_product = PcProduct.unscoped.find_by_id(params[:id])
    @pc_product.attributes = params[:pc_product]
    if !@pc_product.valid?
      render "edit"
    else
      @pc_product.updated_by = current_user.id
      @pc_product.save!
      flash[:alert] = 'PcProduct successfully modified and is pending for approval'
      redirect_to @pc_product
    end
    rescue ActiveRecord::StaleObjectError
      @pc_product.reload
      flash[:alert] = 'Someone edited the pc_product the same time you did. Please re-apply your changes to the pc_product.'
      render "edit"
  end 

  def show
    @pc_product = PcProduct.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc_products = find_pc_products(params).order("id desc")
    else
      pc_products = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcProduct.unscoped.where("approval_status =?",'U').order("id desc") : PcProduct.order("id desc")
      pc_products = pc_products.where("program_code=?",params[:program_code]) if params[:program_code].present?
    end
    @pc_products_count = pc_products.count
    @pc_products = pc_products.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @pc_product = PcProduct.unscoped.find(params[:id]) rescue nil
    @audit = @pc_product.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc_product = PcProduct.unscoped.find(params[:id]) rescue nil
    PcProduct.transaction do
      approval = @pc_product.approve
      if @pc_product.save and approval.empty?
        flash[:alert] = "PcProduct record was approved successfully"
      else
        msg = approval.empty? ? @pc_product.errors.full_messages : @pc_product.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc_product
  end
  
  def encrypt_password
    @pc_product = PcProduct.unscoped.find_by_id(params[:id])
    if params[:generate] == "true"
      encrypted_password = EncPassGenerator.new(params[:pass], @pc_product.mm_consumer_key, @pc_product.mm_consumer_secret)
      @encrypted_password = encrypted_password.generate_encrypted_password
    end
  end

  private

  def pc_product_params
    params.require(:pc_product).permit(:code, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, 
      :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password, 
      :is_enabled, :created_by, :updated_by, :lock_version,
      :approval_status, :last_action, :approved_version, :approved_id, :card_acct, :sc_gl_income, :display_name, 
      :cust_care_no, :rkb_user, :rkb_password, :rkb_bcagent, :rkb_channel_partner, :program_code,
      :card_cust_id)
  end
end
