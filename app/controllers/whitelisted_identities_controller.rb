require 'will_paginate/array'
include AttachmentsHelper

class WhitelistedIdentitiesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IdentitiesHelper

  def new
    @whitelisted_identity = WhitelistedIdentity.new
    @user = current_user
  end

  def create
    @whitelisted_identity = WhitelistedIdentity.new(params[:whitelisted_identity])
    if !@whitelisted_identity.valid?
      flash[:alert] = @whitelisted_identity.errors.full_messages.to_sentence
      redirect_to :back
    else
      @whitelisted_identity.created_by = current_user.id
      if @whitelisted_identity.save!
        EmailAlert.send_email(@whitelisted_identity.inward_remittance,@whitelisted_identity.partner.ops_email_id) rescue nil
      end
      flash[:alert] = 'Identity successfully verified'
      redirect_to :back
    end
  end 

  def index
    if params[:advanced_search].present?
      whitelisted_identities = find_identities(params).order("id desc")
    else
      whitelisted_identities = (params[:approval_status].present? and params[:approval_status] == 'U') ? WhitelistedIdentity.unscoped.where("approval_status =?",'U').order("id desc") : WhitelistedIdentity.order("id desc")
    end
    @whitelisted_identities_count = whitelisted_identities.count
    @whitelisted_identities = whitelisted_identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @whitelisted_identity = WhitelistedIdentity.unscoped.find_by_id(params[:id])
  end
  
  def download_attachment
    attachment = Attachment.find_by_id(params[:attachment_id])
    if attachment.nil?
     flash[:notice] = "File not found"
     redirect_to :back
    elsif attachment.file.blank? || File.file?(attachment.file.path) == false
      flash[:notice] = 'The attachment has been archived, and is no longer available for download.'
      redirect_to attachment.attachable
    else
      whitelisted_identity = attachment.attachable
      normal_attachment(attachment)
    end
  end
  
  def approve
    @whitelisted_identity = WhitelistedIdentity.unscoped.find(params[:id]) rescue nil
    WhitelistedIdentity.transaction do
      approval = @whitelisted_identity.approve
      if @whitelisted_identity.save and approval.empty?
        flash[:alert] = "WhitelistedIdentity record was approved successfully"
      else
        msg = approval.empty? ? @whitelisted_identity.errors.full_messages : @whitelisted_identity.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @whitelisted_identity
  end

  private

  def whitelisted_identity_params
    params.require(:whitelisted_identity).permit(:created_by, :first_name, :first_used_with_txn_id, :full_name, :id_country, 
                                                 :id_issue_date, :id_expiry_date, :id_number, :id_type, :is_verified, :last_name, 
                                                 :last_used_with_txn_id, :lock_version, :partner_id, :times_used,
                                                 :updated_by, :verified_at, :verified_by, {:attachments_attributes => [:note, :user_id, :file, :_destroy]},
                                                 :approved_id, :approved_version)
  end
end