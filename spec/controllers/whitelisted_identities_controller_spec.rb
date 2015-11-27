require 'spec_helper'
require "cancan_matcher"

describe WhitelistedIdentitiesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new whitelisted_identitiy" do
        params = Factory.attributes_for(:whitelisted_identity)
        expect {
          post :create, {:whitelisted_identity => params}
        }.to change(WhitelistedIdentity.unscoped, :count).by(1)
        flash[:alert].should  match(/Identity successfully verified/)
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
        whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
        get :index
        assigns(:whitelisted_identities).should eq([whitelisted_identity])
      end
      
      it "assigns all unapproved whitelisted identities as @whitelisted identities when approval_status is passed" do
        whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'U')
        get :index, :approval_status => 'U'
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
         whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
         get :download_attachment, attachment_id: 0
         flash[:notice].should match /File not found/
         attachment = Factory(:attachment, user_id: @user.id, attachable_id: whitelisted_identity.id, attachable_type: "WhitelistedIdentity")
         File.delete(attachment.file.path)
         get :download_attachment, attachment_id: attachment.id
         flash[:notice].should match /The attachment has been archived, and is no longer available for download./
       end
     end
   end
   
   describe "PUT approve" do
     it "(edit) unapproved record can be approved and old approved record will be updated" do
       user_role = UserRole.find_by_user_id(@user.id)
       user_role.delete
       Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
       whitelisted_identity1 = Factory(:whitelisted_identity, :approval_status => 'A')
       whitelisted_identity2 = Factory(:whitelisted_identity, :approval_status => 'U', :full_name => 'Bar Foo', :approved_version => whitelisted_identity1.lock_version, :approved_id => whitelisted_identity1.id, :created_by => 666)
       # the following line is required for reload to get triggered (TODO)
       whitelisted_identity1.approval_status.should == 'A'
       InwUnapprovedRecord.count.should == 1
       put :approve, {:id => whitelisted_identity2.id}
       InwUnapprovedRecord.count.should == 0
       whitelisted_identity1.reload
       whitelisted_identity1.full_name.should == 'Bar Foo'
       whitelisted_identity1.updated_by.should == "666"
       WhitelistedIdentity.find_by_id(whitelisted_identity2.id).should be_nil
     end

     it "(create) unapproved record can be approved" do
       user_role = UserRole.find_by_user_id(@user.id)
       user_role.delete
       Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
       whitelisted_identity = Factory(:whitelisted_identity, :full_name => 'Bar Foo', :approval_status => 'U')
       InwUnapprovedRecord.count.should == 1
       put :approve, {:id => whitelisted_identity.id}
       InwUnapprovedRecord.count.should == 0
       whitelisted_identity.reload
       whitelisted_identity.full_name.should == 'Bar Foo'
       whitelisted_identity.approval_status.should == 'A'
     end

   end
  
end