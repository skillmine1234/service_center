require 'will_paginate/array'

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
      @whitelisted_identity.save
      flash[:alert] = 'Identity successfuly verified'
      redirect_to :back
    end
  end 

  private

  def whitelisted_identity_params
    params.require(:whitelisted_identity).permit(:created_by, :first_name, :first_used_with_txn_id, :full_name, :id_country, 
                                                 :id_issue_date, :id_expiry_date, :id_number, :id_type, :is_verified, :last_name, 
                                                 :last_used_with_txn_id, :lock_version, :partner_id, :times_used,
                                                 :updated_by, :verified_at, :verified_by, :attachments_attributes)
  end
end