require 'spec_helper'
require "cancan_matcher"

describe WhitelistedIdentitiesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new whitelisted_identitiy" do
        params = Factory.attributes_for(:whitelisted_identity)
        expect {
          post :create, {:whitelisted_identity => params}
        }.to change(WhitelistedIdentity, :count).by(1)
        flash[:alert].should  match(/Identity successfuly verified/)
        response.should be_redirect
      end

      it "assigns a newly created whitelisted_identitiy as @whitelisted_identitiy" do
        params = Factory.attributes_for(:whitelisted_identity)
        post :create, {:whitelisted_identity => params}
        assigns(:whitelisted_identity).should be_a(WhitelistedIdentity)
        assigns(:whitelisted_identity).should be_persisted
      end

      it "redirects to the created whitelisted_identitiy" do
        params = Factory.attributes_for(:whitelisted_identity)
        post :create, {:whitelisted_identity => params}
        response.should be_redirect
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved whitelisted_identitiy as @whitelisted_identitiy" do
        params = Factory.attributes_for(:whitelisted_identity)
        params[:partner_id] = nil
        expect {
          post :create, {:whitelisted_identity => params}
        }.to change(WhitelistedIdentity, :count).by(0)
        assigns(:whitelisted_identity).should be_a(WhitelistedIdentity)
        assigns(:whitelisted_identity).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:whitelisted_identity)
        params[:partner_id] = nil
        post :create, {:whitelisted_identity => params}
        response.should be_redirect
      end
    end
  end
end
