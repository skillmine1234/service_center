require 'will_paginate/array'
include AttachmentsHelper

class WhitelistedIdentitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

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
      if @whitelisted_identity.save
        EmailAlert.send_email(@whitelisted_identity.inward_remittance,@whitelisted_identity.partner.ops_email_id) rescue nil
      end
      flash[:alert] = 'Identity successfully verified'
      redirect_to :back
    end
  end 
  
  def index
    whitelisted_identities = WhitelistedIdentity.order("id desc")
    @whitelisted_identities_count = whitelisted_identities.count
    @whitelisted_identities = whitelisted_identities.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @whitelisted_identity = WhitelistedIdentity.find_by_id(params[:id])
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

  private

  def whitelisted_identity_params
    params.require(:whitelisted_identity).permit(:created_by, :first_name, :first_used_with_txn_id, :full_name, :id_country, 
                                                 :id_issue_date, :id_expiry_date, :id_number, :id_type, :is_verified, :last_name, 
                                                 :last_used_with_txn_id, :lock_version, :partner_id, :times_used,
                                                 :updated_by, :verified_at, :verified_by, {:attachments_attributes => [:note, :user_id, :file, :_destroy]})
  end
end