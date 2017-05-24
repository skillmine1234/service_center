require 'spec_helper'

describe Pc2CustAccountsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc2_cust_accounts as @pc2_cust_accounts" do
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'A')
      get :index
      assigns(:pc2_cust_accounts).should eq([pc2_cust_account])
    end
    
    it "assigns all unapproved pc2_cust_accounts as @pc2_cust_accounts when approval_status is passed" do
      pc2_cust_account = Factory(:pc2_cust_account)
      get :index, :approval_status => 'U'
      assigns(:pc2_cust_accounts).should eq([pc2_cust_account])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc2_cust_account as @pc2_cust_account" do
      pc2_cust_account = Factory(:pc2_cust_account)
      get :show, {:id => pc2_cust_account.id}
      assigns(:pc2_cust_account).should eq(pc2_cust_account)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc2_cust_account as @pc2_cust_account" do
      get :new
      assigns(:pc2_cust_account).should be_a_new(Pc2CustAccount)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc2_cust_account with status 'U' as @pc2_cust_account" do
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'U')
      get :edit, {:id => pc2_cust_account.id}
      assigns(:pc2_cust_account).should eq(pc2_cust_account)
    end

    it "assigns the requested pc2_cust_account with status 'A' as @pc2_cust_account" do
      pc2_cust_account = Factory(:pc2_cust_account,:approval_status => 'A')
      get :edit, {:id => pc2_cust_account.id}
      assigns(:pc2_cust_account).should eq(pc2_cust_account)
    end

    it "assigns the new pc2_cust_account with requested pc2_cust_account params when status 'A' as @pc2_cust_account" do
      pc2_cust_account = Factory(:pc2_cust_account,:approval_status => 'A')
      params = (pc2_cust_account.attributes).merge({:approved_id => pc2_cust_account.id, :approved_version => pc2_cust_account.lock_version})
      get :edit, {:id => pc2_cust_account.id}
      assigns(:pc2_cust_account).should eq(Pc2CustAccount.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc2_cust_account" do
        params = Factory.attributes_for(:pc2_cust_account)
        expect {
          post :create, {:pc2_cust_account => params}
        }.to change(Pc2CustAccount.unscoped, :count).by(1)
        flash[:alert].should  match(/Customer Account successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created pc2_cust_account as @pc2_cust_account" do
        params = Factory.attributes_for(:pc2_cust_account)
        post :create, {:pc2_cust_account => params}
        assigns(:pc2_cust_account).should be_a(Pc2CustAccount)
        assigns(:pc2_cust_account).should be_persisted
      end

      it "redirects to the created pc2_cust_account" do
        params = Factory.attributes_for(:pc2_cust_account)
        post :create, {:pc2_cust_account => params}
        response.should redirect_to(Pc2CustAccount.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc2_cust_account as @pc2_cust_account" do
        params = Factory.attributes_for(:pc2_cust_account)
        params[:account_no] = nil
        expect {
          post :create, {:pc2_cust_account => params}
        }.to change(Pc2CustAccount, :count).by(0)
        assigns(:pc2_cust_account).should be_a(Pc2CustAccount)
        assigns(:pc2_cust_account).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc2_cust_account)
        params[:account_no] = nil
        post :create, {:pc2_cust_account => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc2_cust_account" do
        pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789")
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = "123456788"
        put :update, {:id => pc2_cust_account.id, :pc2_cust_account => params}
        pc2_cust_account.reload
        pc2_cust_account.account_no.should == "123456788"
      end

      it "assigns the requested pc2_cust_account as @pc2_cust_account" do
        pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789")
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = "123456788"
        put :update, {:id => pc2_cust_account.to_param, :pc2_cust_account => params}
        assigns(:pc2_cust_account).should eq(pc2_cust_account)
      end

      it "redirects to the pc2_cust_account" do
        pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789")
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = "123456789"
        put :update, {:id => pc2_cust_account.to_param, :pc2_cust_account => params}
        response.should redirect_to(pc2_cust_account)
      end

      it "should raise error when tried to update at same time by many" do
        pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789")
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = "123456788"
        pc2_cust_account2 = pc2_cust_account
        put :update, {:id => pc2_cust_account.id, :pc2_cust_account => params}
        pc2_cust_account.reload
        pc2_cust_account.account_no.should == "123456788"
        params[:account_no] = "123456787"
        put :update, {:id => pc2_cust_account2.id, :pc2_cust_account => params}
        pc2_cust_account.reload
        pc2_cust_account.account_no.should == "123456788"
        flash[:alert].should  match(/Someone edited the Customer Account the same time you did. Please re-apply your changes to the Customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc2_cust_account as @pc2_cust_account" do
        pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789")
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = nil
        put :update, {:id => pc2_cust_account.to_param, :pc2_cust_account => params}
        assigns(:pc2_cust_account).should eq(pc2_cust_account)
        pc2_cust_account.reload
        params[:account_no] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc2_cust_account = Factory(:pc2_cust_account)
        params = pc2_cust_account.attributes.slice(*pc2_cust_account.class.attribute_names)
        params[:account_no] = nil
        put :update, {:id => pc2_cust_account.id, :pc2_cust_account => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc2_cust_account as @pc2_cust_account" do
      pc2_cust_account = Factory(:pc2_cust_account)
      get :audit_logs, {:id => pc2_cust_account.id, :version_id => 0}
      assigns(:record).should eq(pc2_cust_account)
      assigns(:audit).should eq(pc2_cust_account.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc2_cust_account1 = Factory(:pc2_cust_account, :approval_status => 'A')
      pc2_cust_account2 = Factory(:pc2_cust_account, :account_no => "123456789", :approval_status => 'U', :approved_version => pc2_cust_account1.lock_version, :approved_id => pc2_cust_account1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      pc2_cust_account1.approval_status.should == 'A'
      Pc2UnapprovedRecord.count.should == 1
      put :approve, {:id => pc2_cust_account2.id}
      Pc2UnapprovedRecord.count.should == 0
      pc2_cust_account1.reload
      pc2_cust_account1.account_no.should == "123456789"
      pc2_cust_account1.updated_by.should == "666"
      Pc2CustAccount.find_by_id(pc2_cust_account2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc2_cust_account = Factory(:pc2_cust_account, :account_no => "123456789", :approval_status => 'U')
      Pc2UnapprovedRecord.count.should == 1
      put :approve, {:id => pc2_cust_account.id}
      Pc2UnapprovedRecord.count.should == 0
      pc2_cust_account.reload
      pc2_cust_account.account_no.should == "123456789"
      pc2_cust_account.approval_status.should == 'A'
    end
  end
end
