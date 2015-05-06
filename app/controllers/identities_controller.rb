require 'will_paginate/array'

class IdentitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def verify_identity
    identity = Identity.find(params[:id])
    whitelist_identity = WhitelistedIdentity.new(partner_id: identity.partner_id, full_name: identity.full_name,
                                                 first_name: identity.first_name, last_name: identity.last_name, 
                                                 id_type: identity.id_type, id_number: identity.id_number, 
                                                 id_country: identity.id_country, id_issue_date: identity.id_issue_date,
                                                 id_expiry_date: identity.id_expiry_date, is_verified: 'Y', 
                                                 verified_at: Time.zone.today, verified_by: current_user.id, 
                                                 created_by: current_user.id, updated_by: current_user.id, lock_version: 0)
    if whitelist_identity.save
      flash[:alert] = 'Identity was successfully verified.'
      redirect_to :back
    else
      flash[:alert] = 'Identity was not verified.'
      redirect_to :back
    end
  end
end