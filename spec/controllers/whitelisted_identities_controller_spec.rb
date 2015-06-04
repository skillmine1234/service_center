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
    
    describe "GET index" do
      it "assigns all whitelisted identities as @whitelisted_identities" do
        whitelisted_identity = Factory(:whitelisted_identity)
        get :index
        assigns(:whitelisted_identities).should eq([whitelisted_identity])
      end
    end

    describe "GET show" do
      it "assigns the requested whitelisted identity as @whitelisted_identity" do
        whitelisted_identity = Factory(:whitelisted_identity)
        get :show, {:id => whitelisted_identity.id}
        assigns(:whitelisted_identity).should eq(whitelisted_identity)
      end
    end    
  end
  
   describe "GET " do
     describe 'download Attachment' do
       it 'should download attachment' do
         whitelisted_identity = Factory(:whitelisted_identity)
         get :download_attachment, attachment_id: 0
         flash[:notice].should match /File not found/
         attachment = Factory(:attachment, user_id: @user.id, attachable_id: whitelisted_identity.id, attachable_type: "WhitelistedIdentity")
         File.delete(attachment.file.path)
         get :download_attachment, attachment_id: attachment.id
         flash[:notice].should match /The attachment has been archived, and is no longer available for download./
       end
     end
    end
end
