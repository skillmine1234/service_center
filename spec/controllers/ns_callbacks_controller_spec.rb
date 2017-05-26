require 'spec_helper'

describe NsCallbacksController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET show" do
    it "assigns the requested ns_callback as @ns_callback" do
      ns_callback = Factory(:ns_callback)
      get :show, {:id => ns_callback.id}
      assigns(:ns_callback).should eq(ns_callback)
    end
  end
  
  describe "GET index" do
    it "assigns all ns_callbacks as @ns_callbacks" do
      ns_callback = Factory(:ns_callback, :approval_status => 'A')
      get :index
      assigns(:ns_callbacks).should eq([ns_callback])
    end
    
    it "assigns all unapproved ns_callbacks as @ns_callbacks when approval_status is passed" do
      ns_callback = Factory(:ns_callback, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:ns_callbacks).should eq([ns_callback])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested ns_callback as @ns_callback" do
      ns_callback = Factory(:ns_callback, :approval_status => 'A')
      get :edit, {:id => ns_callback.id}
      assigns(:ns_callback).should eq(ns_callback)
    end
    
    it "assigns the requested ns_callback with status 'A' as @ns_callback" do
      ns_callback = Factory(:ns_callback,:approval_status => 'A')
      get :edit, {:id => ns_callback.id}
      assigns(:ns_callback).should eq(ns_callback)
    end

    it "assigns the new ns_callback with requested ns_callback params when status 'A' as @ns_callback" do
      ns_callback = Factory(:ns_callback,:approval_status => 'A')
      params = (ns_callback.attributes).merge({:approved_id => ns_callback.id,:approved_version => ns_callback.lock_version})
      get :edit, {:id => ns_callback.id}
      assigns(:ns_callback).should eq(NsCallback.new(params))
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ns_callback" do
        ns_callback = Factory(:ns_callback, :notify_url => "http://localhost")
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => ns_callback.id, :ns_callback => params}
        ns_callback.reload
        ns_callback.notify_url.should == "https://www.google.com"
      end

      it "assigns the requested ns_callback as @ns_callback" do
        ns_callback = Factory(:ns_callback, :notify_url => "http://localhost")
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => ns_callback.to_param, :ns_callback => params}
        assigns(:ns_callback).should eq(ns_callback)
      end

      it "redirects to the ns_callback" do
        ns_callback = Factory(:ns_callback, :notify_url => "http://localhost")
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => ns_callback.to_param, :ns_callback => params}
        response.should redirect_to(ns_callback)
      end

      it "should raise error when tried to update at same time by many" do
        ns_callback = Factory(:ns_callback, :notify_url => "http://localhost")
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        ns_callback2 = ns_callback
        put :update, {:id => ns_callback.id, :ns_callback => params}
        ns_callback.reload
        ns_callback.notify_url.should == "https://www.google.com"
        params[:notify_url] = "https://www.yahoo.com"
        put :update, {:id => ns_callback2.id, :ns_callback => params}
        ns_callback.reload
        ns_callback.notify_url.should == "https://www.google.com"
        flash[:alert].should  match(/Someone edited the ns_callback the same time you did. Please re-apply your changes to the ns_callback/)
      end
    end

    describe "with invalid params" do
      it "assigns the ns_callback as @ns_callback" do
        ns_callback = Factory(:ns_callback, :notify_url => "http://localhost")
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:notify_url] = nil
        put :update, {:id => ns_callback.to_param, :ns_callback => params}
        assigns(:ns_callback).should eq(ns_callback)
        ns_callback.reload
        params[:notify_url] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ns_callback = Factory(:ns_callback)
        params = ns_callback.attributes.slice(*ns_callback.class.attribute_names)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        put :update, {:id => ns_callback.id, :ns_callback => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ns_callback" do
        params = Factory.attributes_for(:ns_callback)
        expect {
          post :create, {:ns_callback => params}
        }.to change(NsCallback.unscoped, :count).by(1)
        flash[:alert].should  match(/Callback record successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created ns_callback as @ns_callback" do
        params = Factory.attributes_for(:ns_callback)
        post :create, {:ns_callback => params}
        assigns(:ns_callback).should be_a(NsCallback)
        assigns(:ns_callback).should be_persisted
      end

      it "redirects to the created ns_callback" do
        params = Factory.attributes_for(:ns_callback)
        post :create, {:ns_callback => params}
        response.should redirect_to(NsCallback.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ns_callback as @ns_callback" do
        params = Factory.attributes_for(:ns_callback)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        expect {
          post :create, {:ns_callback => params}
        }.to change(NsCallback, :count).by(0)
        assigns(:ns_callback).should be_a(NsCallback)
        assigns(:ns_callback).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ns_callback)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        post :create, {:ns_callback => params}
        response.should render_template("edit")
      end
    end
  end
  
  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ns_callback1 = Factory(:ns_callback, :approval_status => 'A')
      ns_callback2 = Factory(:ns_callback, :approval_status => 'U', :notify_url => "http://localhost", :approved_version => ns_callback1.lock_version, :approved_id => ns_callback1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ns_callback1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => ns_callback2.id}
      UnapprovedRecord.count.should == 0
      ns_callback1.reload
      ns_callback1.notify_url.should == 'http://localhost'
      ns_callback1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(ns_callback2.id).should be_nil
    end
  end
  
  describe "GET audit_logs" do
    it "assigns the requested ns_callback as @ns_callback" do
      ns_callback = Factory(:ns_callback)
      get :audit_logs, {:id => ns_callback.id, :version_id => 0}
      assigns(:record).should eq(ns_callback)
      assigns(:audit).should eq(ns_callback.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

end
