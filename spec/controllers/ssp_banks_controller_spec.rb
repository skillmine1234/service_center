require 'spec_helper'

describe SspBanksController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET new" do
    it "assigns a new ssp_bank as @ssp_bank" do
      get :new
      assigns(:ssp_bank).should be_a_new(SspBank)
    end
  end

  describe "GET show" do
    it "assigns the requested ssp_bank as @ssp_bank" do
      ssp_bank = Factory(:ssp_bank)
      get :show, {:id => ssp_bank.id}
      assigns(:ssp_bank).should eq(ssp_bank)
    end
  end
  
  describe "GET index" do
    it "assigns all ssp_banks as @ssp_banks" do
      ssp_bank = Factory(:ssp_bank, :approval_status => 'A')
      get :index
      assigns(:records).should eq([ssp_bank])
    end
    
    it "assigns all unapproved ssp_banks as @ssp_banks when approval_status is passed" do
      ssp_bank = Factory(:ssp_bank, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:records).should eq([ssp_bank])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested ssp_bank as @ssp_bank" do
      ssp_bank = Factory(:ssp_bank, :approval_status => 'A')
      get :edit, {:id => ssp_bank.id}
      assigns(:ssp_bank).should eq(ssp_bank)
    end
    
    it "assigns the requested ssp_bank with status 'A' as @ssp_bank" do
      ssp_bank = Factory(:ssp_bank,:approval_status => 'A')
      get :edit, {:id => ssp_bank.id}
      assigns(:ssp_bank).should eq(ssp_bank)
    end

    it "assigns the new ssp_bank with requested ssp_bank params when status 'A' as @ssp_bank" do
      ssp_bank = Factory(:ssp_bank,:approval_status => 'A')
      params = (ssp_bank.attributes).merge({:approved_id => ssp_bank.id,:approved_version => ssp_bank.lock_version})
      get :edit, {:id => ssp_bank.id}
      assigns(:ssp_bank).should eq(SspBank.new(params))
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ssp_bank" do
        ssp_bank = Factory(:ssp_bank, :debit_account_url => "http://localhost")
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:debit_account_url] = "https://www.google.com"
        put :update, {:id => ssp_bank.id, :ssp_bank => params}
        ssp_bank.reload
        ssp_bank.debit_account_url.should == "https://www.google.com"
      end

      it "assigns the requested ssp_bank as @ssp_bank" do
        ssp_bank = Factory(:ssp_bank, :debit_account_url => "http://localhost")
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:debit_account_url] = "https://www.google.com"
        put :update, {:id => ssp_bank.to_param, :ssp_bank => params}
        assigns(:ssp_bank).should eq(ssp_bank)
      end

      it "redirects to the ssp_bank" do
        ssp_bank = Factory(:ssp_bank, :debit_account_url => "http://localhost")
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:debit_account_url] = "https://www.google.com"
        put :update, {:id => ssp_bank.to_param, :ssp_bank => params}
        response.should redirect_to(ssp_bank)
      end

      it "should raise error when tried to update at same time by many" do
        ssp_bank = Factory(:ssp_bank, :debit_account_url => "http://localhost")
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:debit_account_url] = "https://www.google.com"
        ssp_bank2 = ssp_bank
        put :update, {:id => ssp_bank.id, :ssp_bank => params}
        ssp_bank.reload
        ssp_bank.debit_account_url.should == "https://www.google.com"
        params[:debit_account_url] = "https://www.yahoo.com"
        put :update, {:id => ssp_bank2.id, :ssp_bank => params}
        ssp_bank.reload
        ssp_bank.debit_account_url.should == "https://www.google.com"
        flash[:alert].should  match(/Someone edited the SimSePay Bank the same time you did. Please re-apply your changes to the SimSePay Bank/)
      end
    end

    describe "with invalid params" do
      it "assigns the ssp_bank as @ssp_bank" do
        ssp_bank = Factory(:ssp_bank)
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:app_code] = nil
        put :update, {:id => ssp_bank.to_param, :ssp_bank => params}
        assigns(:ssp_bank).should eq(ssp_bank)
        ssp_bank.reload
        params[:app_code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ssp_bank = Factory(:ssp_bank)
        params = ssp_bank.attributes.slice(*ssp_bank.class.attribute_names)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        put :update, {:id => ssp_bank.id, :ssp_bank => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ssp_bank" do
        params = Factory.attributes_for(:ssp_bank)
        expect {
          post :create, {:ssp_bank => params}
        }.to change(SspBank.unscoped, :count).by(1)
        flash[:alert].should  match(/SimSePay Bank successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created ssp_bank as @ssp_bank" do
        params = Factory.attributes_for(:ssp_bank)
        post :create, {:ssp_bank => params}
        assigns(:ssp_bank).should be_a(SspBank)
        assigns(:ssp_bank).should be_persisted
      end

      it "redirects to the created ssp_bank" do
        params = Factory.attributes_for(:ssp_bank)
        post :create, {:ssp_bank => params}
        response.should redirect_to(SspBank.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ssp_bank as @ssp_bank" do
        params = Factory.attributes_for(:ssp_bank)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        expect {
          post :create, {:ssp_bank => params}
        }.to change(SspBank, :count).by(0)
        assigns(:ssp_bank).should be_a(SspBank)
        assigns(:ssp_bank).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ssp_bank)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        post :create, {:ssp_bank => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ssp_bank1 = Factory(:ssp_bank, :approval_status => 'A')
      ssp_bank2 = Factory(:ssp_bank, :approval_status => 'U', :debit_account_url => "http://localhost", :approved_version => ssp_bank1.lock_version, :approved_id => ssp_bank1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ssp_bank1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => ssp_bank2.id}
      UnapprovedRecord.count.should == 0
      ssp_bank1.reload
      ssp_bank1.debit_account_url.should == 'http://localhost'
      ssp_bank1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(ssp_bank2.id).should be_nil
    end
  end
  
  describe "GET audit_logs" do
    it "assigns the requested ssp_bank as @ssp_bank" do
      ssp_bank = Factory(:ssp_bank)
      get :audit_logs, {:id => ssp_bank.id, :version_id => 0}
      assigns(:record).should eq(ssp_bank)
      assigns(:audit).should eq(ssp_bank.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end