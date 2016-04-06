require 'spec_helper'

describe Pc2AppsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc2_apps as @pc2_apps" do
      pc2_app = Factory(:pc2_app, :approval_status => 'A')
      get :index
      assigns(:pc2_apps).should eq([pc2_app])
    end
    
    it "assigns all unapproved pc2_apps as @pc2_apps when approval_status is passed" do
      pc2_app = Factory(:pc2_app)
      get :index, :approval_status => 'U'
      assigns(:pc2_apps).should eq([pc2_app])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc2_app as @pc2_app" do
      pc2_app = Factory(:pc2_app)
      get :show, {:id => pc2_app.id}
      assigns(:pc2_app).should eq(pc2_app)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc2_app as @pc2_app" do
      get :new
      assigns(:pc2_app).should be_a_new(Pc2App)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc2_app with status 'U' as @pc2_app" do
      pc2_app = Factory(:pc2_app, :approval_status => 'U')
      get :edit, {:id => pc2_app.id}
      assigns(:pc2_app).should eq(pc2_app)
    end

    it "assigns the requested pc2_app with status 'A' as @pc2_app" do
      pc2_app = Factory(:pc2_app,:approval_status => 'A')
      get :edit, {:id => pc2_app.id}
      assigns(:pc2_app).should eq(pc2_app)
    end

    it "assigns the new pc2_app with requested pc2_app params when status 'A' as @pc2_app" do
      pc2_app = Factory(:pc2_app,:approval_status => 'A')
      params = (pc2_app.attributes).merge({:approved_id => pc2_app.id,:approved_version => pc2_app.lock_version})
      get :edit, {:id => pc2_app.id}
      assigns(:pc2_app).should eq(Pc2App.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc2_app" do
        params = Factory.attributes_for(:pc2_app)
        expect {
          post :create, {:pc2_app => params}
        }.to change(Pc2App.unscoped, :count).by(1)
        flash[:alert].should  match(/Pc2App successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created pc2_app as @pc2_app" do
        params = Factory.attributes_for(:pc2_app)
        post :create, {:pc2_app => params}
        assigns(:pc2_app).should be_a(Pc2App)
        assigns(:pc2_app).should be_persisted
      end

      it "redirects to the created pc2_app" do
        params = Factory.attributes_for(:pc2_app)
        post :create, {:pc2_app => params}
        response.should redirect_to(Pc2App.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc2_app as @pc2_app" do
        params = Factory.attributes_for(:pc2_app)
        params[:app_id] = nil
        expect {
          post :create, {:pc2_app => params}
        }.to change(Pc2App, :count).by(0)
        assigns(:pc2_app).should be_a(Pc2App)
        assigns(:pc2_app).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc2_app)
        params[:app_id] = nil
        post :create, {:pc2_app => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc2_app" do
        pc2_app = Factory(:pc2_app, :app_id => "App01")
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc2_app.id, :pc2_app => params}
        pc2_app.reload
        pc2_app.app_id.should == "App02"
      end

      it "assigns the requested pc2_app as @pc2_app" do
        pc2_app = Factory(:pc2_app, :app_id => "App01")
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc2_app.to_param, :pc2_app => params}
        assigns(:pc2_app).should eq(pc2_app)
      end

      it "redirects to the pc2_app" do
        pc2_app = Factory(:pc2_app, :app_id => "App01")
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = "App02"
        put :update, {:id => pc2_app.to_param, :pc2_app => params}
        response.should redirect_to(pc2_app)
      end

      it "should raise error when tried to update at same time by many" do
        pc2_app = Factory(:pc2_app, :app_id => "App01")
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = "App02"
        pc2_app2 = pc2_app
        put :update, {:id => pc2_app.id, :pc2_app => params}
        pc2_app.reload
        pc2_app.app_id.should == "App02"
        params[:app_id] = "App03"
        put :update, {:id => pc2_app2.id, :pc2_app => params}
        pc2_app.reload
        pc2_app.app_id.should == "App02"
        flash[:alert].should  match(/Someone edited the pc2_app the same time you did. Please re-apply your changes to the pc2_app/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc2_app as @pc2_app" do
        pc2_app = Factory(:pc2_app, :app_id => "CUST01")
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = nil
        put :update, {:id => pc2_app.to_param, :pc2_app => params}
        assigns(:pc2_app).should eq(pc2_app)
        pc2_app.reload
        params[:app_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc2_app = Factory(:pc2_app)
        params = pc2_app.attributes.slice(*pc2_app.class.attribute_names)
        params[:app_id] = nil
        put :update, {:id => pc2_app.id, :pc2_app => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc2_app as @pc2_app" do
      pc2_app = Factory(:pc2_app)
      get :audit_logs, {:id => pc2_app.id, :version_id => 0}
      assigns(:pc2_app).should eq(pc2_app)
      assigns(:audit).should eq(pc2_app.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:pc2_app).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc2_app1 = Factory(:pc2_app, :app_id => "App01", :approval_status => 'A')
      pc2_app2 = Factory(:pc2_app, :app_id => "App01", :approval_status => 'U', :customer_id => 'Foobar', :approved_version => pc2_app1.lock_version, :approved_id => pc2_app1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      pc2_app1.approval_status.should == 'A'
      Pc2UnapprovedRecord.count.should == 1
      put :approve, {:id => pc2_app2.id}
      Pc2UnapprovedRecord.count.should == 0
      pc2_app1.reload
      pc2_app1.customer_id.should == 'Foobar'
      pc2_app1.updated_by.should == "666"
      Pc2App.find_by_id(pc2_app2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc2_app = Factory(:pc2_app, :app_id => "App01", :approval_status => 'U', :customer_id => 'Foobar')
      Pc2UnapprovedRecord.count.should == 1
      put :approve, {:id => pc2_app.id}
      Pc2UnapprovedRecord.count.should == 0
      pc2_app.reload
      pc2_app.customer_id.should == 'Foobar'
      pc2_app.approval_status.should == 'A'
    end
  end
end
