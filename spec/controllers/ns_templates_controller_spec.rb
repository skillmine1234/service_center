require 'spec_helper'

describe NsTemplatesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET new" do
    it "assigns a new template as @ns_template" do
      get :new
      assigns(:ns_template).should be_a_new(NsTemplate)
    end
  end

  describe "GET show" do
    it "assigns the requested ns_template as @ns_template" do
      ns_template = Factory(:ns_template)
      get :show, {:id => ns_template.id}
      assigns(:ns_template).should eq(ns_template)
    end
  end
  
  describe "GET index" do
    it "assigns all ns_templates as @ns_templates" do
      ns_template = Factory(:ns_template, :approval_status => 'A')
      get :index
      assigns(:ns_templates).should eq([ns_template])
    end
    
    it "assigns all unapproved ns_templates as @ns_templates when approval_status is passed" do
      ns_template = Factory(:ns_template, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:ns_templates).should eq([ns_template])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested ns_template as @ns_template" do
      ns_template = Factory(:ns_template, :approval_status => 'A')
      get :edit, {:id => ns_template.id}
      assigns(:ns_template).should eq(ns_template)
    end
    
    it "assigns the requested ns_template with status 'A' as @ns_template" do
      ns_template = Factory(:ns_template,:approval_status => 'A')
      get :edit, {:id => ns_template.id}
      assigns(:ns_template).should eq(ns_template)
    end

    it "assigns the new ns_template with requested ns_template params when status 'A' as @ns_template" do
      ns_template = Factory(:ns_template,:approval_status => 'A')
      params = (ns_template.attributes).merge({:approved_id => ns_template.id,:approved_version => ns_template.lock_version})
      get :edit, {:id => ns_template.id}
      assigns(:ns_template).should eq(NsTemplate.new(params))
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ns_template" do
        ns_template = Factory(:ns_template, :sms_text => "http://localhost")
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = "https://www.google.com"
        put :update, {:id => ns_template.id, :ns_template => params}
        ns_template.reload
        ns_template.sms_text.should == "https://www.google.com"
      end

      it "assigns the requested ns_template as @ns_template" do
        ns_template = Factory(:ns_template, :sms_text => "http://localhost")
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = "https://www.google.com"
        put :update, {:id => ns_template.to_param, :ns_template => params}
        assigns(:ns_template).should eq(ns_template)
      end

      it "redirects to the ns_template" do
        ns_template = Factory(:ns_template, :sms_text => "http://localhost")
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = "https://www.google.com"
        put :update, {:id => ns_template.to_param, :ns_template => params}
        response.should redirect_to(ns_template)
      end

      it "should raise error when tried to update at same time by many" do
        ns_template = Factory(:ns_template, :sms_text => "http://localhost")
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = "https://www.google.com"
        ns_template2 = ns_template
        put :update, {:id => ns_template.id, :ns_template => params}
        ns_template.reload
        ns_template.sms_text.should == "https://www.google.com"
        params[:sms_text] = "https://www.yahoo.com"
        put :update, {:id => ns_template2.id, :ns_template => params}
        ns_template.reload
        ns_template.sms_text.should == "https://www.google.com"
        flash[:alert].should  match(/Someone edited the template the same time you did. Please re-apply your changes to the template/)
      end
    end

    describe "with invalid params" do
      it "assigns the ns_template as @ns_template" do
        ns_template = Factory(:ns_template, :sms_text => "http://localhost")
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = nil
        put :update, {:id => ns_template.to_param, :ns_template => params}
        assigns(:ns_template).should eq(ns_template)
        ns_template.reload
        params[:sms_text] = nil
      end

      it "re-renders the 'edit' template when there are errors" do
        ns_template = Factory(:ns_template)
        params = ns_template.attributes.slice(*ns_template.class.attribute_names)
        params[:sms_text] = nil
        params[:email_body] = nil
        put :update, {:id => ns_template.id, :ns_template => params}
        response.should render_template("edit")
      end
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ns_template" do
        params = Factory.attributes_for(:ns_template)
        expect {
          post :create, {:ns_template => params}
        }.to change(NsTemplate.unscoped, :count).by(1)
        flash[:alert].should  match(/Template record successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created ns_template as @ns_template" do
        params = Factory.attributes_for(:ns_template)
        post :create, {:ns_template => params}
        assigns(:ns_template).should be_a(NsTemplate)
        assigns(:ns_template).should be_persisted
      end

      it "redirects to the created ns_template" do
        params = Factory.attributes_for(:ns_template)
        post :create, {:ns_template => params}
        response.should redirect_to(NsTemplate.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ns_template as @ns_template" do
        params = Factory.attributes_for(:ns_template)
        params[:sms_text] = nil
        params[:email_body] = nil
        expect {
          post :create, {:ns_template => params}
        }.to change(NsTemplate, :count).by(0)
        assigns(:ns_template).should be_a(NsTemplate)
        assigns(:ns_template).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ns_template)
        params[:sms_text] = nil
        params[:email_body] = nil
        post :create, {:ns_template => params}
        response.should render_template("edit")
      end
    end
  end
  
  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ns_template1 = Factory(:ns_template, :approval_status => 'A')
      ns_template2 = Factory(:ns_template, :approval_status => 'U', :sms_text => "http://localhost", :approved_version => ns_template1.lock_version, :approved_id => ns_template1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ns_template1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => ns_template2.id}
      UnapprovedRecord.count.should == 0
      ns_template1.reload
      ns_template1.sms_text.should == 'http://localhost'
      ns_template1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(ns_template2.id).should be_nil
    end
  end
  
  describe "GET audit_logs" do
    it "assigns the requested ns_template as @ns_template" do
      ns_template = Factory(:ns_template)
      get :audit_logs, {:id => ns_template.id, :version_id => 0}
      assigns(:record).should eq(ns_template)
      assigns(:audit).should eq(ns_template.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

end
