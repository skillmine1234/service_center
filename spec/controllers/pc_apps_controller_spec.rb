require 'spec_helper'

describe PcAppsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc_apps as @pc_apps" do
      pc_app = Factory(:pc_app, :approval_status => 'A')
      get :index
      assigns(:pc_apps).should eq([pc_app])
    end
    
    it "assigns all unapproved pc_apps as @pc_apps when approval_status is passed" do
      pc_app = Factory(:pc_app)
      get :index, :approval_status => 'U'
      assigns(:pc_apps).should eq([pc_app])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc_app as @pc_app" do
      pc_app = Factory(:pc_app)
      get :show, {:id => pc_app.id}
      assigns(:pc_app).should eq(pc_app)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc_app as @pc_app" do
      get :new
      assigns(:pc_app).should be_a_new(PcApp)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc_app with status 'U' as @pc_app" do
      pc_app = Factory(:pc_app, :approval_status => 'U')
      get :edit, {:id => pc_app.id}
      assigns(:pc_app).should eq(pc_app)
    end

    it "assigns the requested pc_app with status 'A' as @pc_app" do
      pc_app = Factory(:pc_app,:approval_status => 'A')
      get :edit, {:id => pc_app.id}
      assigns(:pc_app).should eq(pc_app)
    end

    it "assigns the new pc_app with requested pc_app params when status 'A' as @pc_app" do
      pc_app = Factory(:pc_app,:approval_status => 'A')
      params = (pc_app.attributes).merge({:approved_id => pc_app.id,:approved_version => pc_app.lock_version})
      get :edit, {:id => pc_app.id}
      assigns(:pc_app).should eq(PcApp.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc_app" do
        params = Factory.attributes_for(:pc_app)
        expect {
          post :create, {:pc_app => params}
        }.to change(PcApp.unscoped, :count).by(1)
        flash[:alert].should  match(/PcApp successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created pc_app as @pc_app" do
        params = Factory.attributes_for(:pc_app)
        post :create, {:pc_app => params}
        assigns(:pc_app).should be_a(PcApp)
        assigns(:pc_app).should be_persisted
      end

      it "redirects to the created pc_app" do
        params = Factory.attributes_for(:pc_app)
        post :create, {:pc_app => params}
        response.should redirect_to(PcApp.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc_app as @pc_app" do
        params = Factory.attributes_for(:pc_app)
        params[:app_id] = nil
        expect {
          post :create, {:pc_app => params}
        }.to change(PcApp, :count).by(0)
        assigns(:pc_app).should be_a(PcApp)
        assigns(:pc_app).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc_app)
        params[:app_id] = nil
        post :create, {:pc_app => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc_app" do
        pc_app = Factory(:pc_app, :app_id => "App01")
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc_app.id, :pc_app => params}
        pc_app.reload
        pc_app.app_id.should == "App02"
      end

      it "assigns the requested pc_app as @pc_app" do
        pc_app = Factory(:pc_app, :app_id => "App01")
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc_app.to_param, :pc_app => params}
        assigns(:pc_app).should eq(pc_app)
      end

      it "redirects to the pc_app" do
        pc_app = Factory(:pc_app, :app_id => "App01")
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc_app.to_param, :pc_app => params}
        response.should redirect_to(pc_app)
      end

      it "should raise error when tried to update at same time by many" do
        pc_app = Factory(:pc_app, :app_id => "App01")
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = "App02"
        pc_app2 = pc_app
        put :update, {:id => pc_app.id, :pc_app => params}
        pc_app.reload
        pc_app.app_id.should == "App02"
        params[:app_id] = "App03"
        put :update, {:id => pc_app2.id, :pc_app => params}
        pc_app.reload
        pc_app.app_id.should == "App02"
        flash[:alert].should  match(/Someone edited the pc_app the same time you did. Please re-apply your changes to the pc_app/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc_app as @pc_app" do
        pc_app = Factory(:pc_app, :app_id => "CUST01")
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = nil
        put :update, {:id => pc_app.to_param, :pc_app => params}
        assigns(:pc_app).should eq(pc_app)
        pc_app.reload
        params[:app_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc_app = Factory(:pc_app)
        params = pc_app.attributes.slice(*pc_app.class.attribute_names)
        params[:app_id] = nil
        put :update, {:id => pc_app.id, :pc_app => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc_app as @pc_app" do
      pc_app = Factory(:pc_app)
      get :audit_logs, {:id => pc_app.id, :version_id => 0}
      assigns(:pc_app).should eq(pc_app)
      assigns(:audit).should eq(pc_app.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:pc_app).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_app1 = Factory(:pc_app, :app_id => "App01", :approval_status => 'A')
      pc_app2 = Factory(:pc_app, :app_id => "App01", :approval_status => 'U', :card_acct => 'Foobar', :approved_version => pc_app1.lock_version, :approved_id => pc_app1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      pc_app1.approval_status.should == 'A'
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_app2.id}
      PcUnapprovedRecord.count.should == 0
      pc_app1.reload
      pc_app1.card_acct.should == 'Foobar'
      pc_app1.updated_by.should == "666"
      PcApp.find_by_id(pc_app2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_app = Factory(:pc_app, :app_id => "App01", :approval_status => 'U', :card_acct => 'Foobar')
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_app.id}
      PcUnapprovedRecord.count.should == 0
      pc_app.reload
      pc_app.card_acct.should == 'Foobar'
      pc_app.approval_status.should == 'A'
    end
  end
end
