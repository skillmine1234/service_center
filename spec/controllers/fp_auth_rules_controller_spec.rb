require 'spec_helper'

describe FpAuthRulesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all fp_auth_rules as @fp_auth_rules" do
      fp_auth_rule = Factory(:fp_auth_rule, :approval_status => 'A')
      get :index
      assigns(:fp_auth_rules).should eq([fp_auth_rule])
    end
    
    it "assigns all unapproved fp_auth_rules as @fp_auth_rules when approval_status is passed" do
      fp_auth_rule = Factory(:fp_auth_rule)
      get :index, :approval_status => 'U'
      assigns(:fp_auth_rules).should eq([fp_auth_rule])
    end
  end
  
  describe "GET show" do
    it "assigns the requested fp_auth_rule as @fp_auth_rule" do
      fp_auth_rule = Factory(:fp_auth_rule)
      get :show, {:id => fp_auth_rule.id}
      assigns(:fp_auth_rule).should eq(fp_auth_rule)
    end
  end
  
  describe "GET new" do
    it "assigns a new fp_auth_rule as @fp_auth_rule" do
      get :new
      assigns(:fp_auth_rule).should be_a_new(FpAuthRule)
    end
  end

  describe "GET edit" do
    it "assigns the requested fp_auth_rule with status 'U' as @fp_auth_rule" do
      fp_auth_rule = Factory(:fp_auth_rule, :approval_status => 'U')
      get :edit, {:id => fp_auth_rule.id}
      assigns(:fp_auth_rule).should eq(fp_auth_rule)
    end

    it "assigns the requested fp_auth_rule with status 'A' as @fp_auth_rule" do
      fp_auth_rule = Factory(:fp_auth_rule,:approval_status => 'A')
      get :edit, {:id => fp_auth_rule.id}
      assigns(:fp_auth_rule).should eq(fp_auth_rule)
    end

    it "assigns the new fp_auth_rule with requested fp_auth_rule params when status 'A' as @fp_auth_rule" do
      fp_auth_rule = Factory(:fp_auth_rule,:approval_status => 'A')
      params = (fp_auth_rule.attributes).merge({:approved_id => fp_auth_rule.id,:approved_version => fp_auth_rule.lock_version})
      get :edit, {:id => fp_auth_rule.id}
      assigns(:fp_auth_rule).should eq(FpAuthRule.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new fp_auth_rule" do
        params = Factory.attributes_for(:fp_auth_rule)
        expect {
          post :create, {:fp_auth_rule => params}
        }.to change(FpAuthRule.unscoped, :count).by(1)
        flash[:alert].should  match(/Authorisation Rule successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created fp_auth_rule as @fp_auth_rule" do
        params = Factory.attributes_for(:fp_auth_rule)
        post :create, {:fp_auth_rule => params}
        assigns(:fp_auth_rule).should be_a(FpAuthRule)
        assigns(:fp_auth_rule).should be_persisted
      end

      it "redirects to the created fp_auth_rule" do
        params = Factory.attributes_for(:fp_auth_rule)
        post :create, {:fp_auth_rule => params}
        response.should redirect_to(FpAuthRule.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved fp_auth_rule as @fp_auth_rule" do
        params = Factory.attributes_for(:fp_auth_rule)
        params[:operation_name] = nil
        expect {
          post :create, {:fp_auth_rule => params}
        }.to change(FpAuthRule, :count).by(0)
        assigns(:fp_auth_rule).should be_a(FpAuthRule)
        assigns(:fp_auth_rule).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:fp_auth_rule)
        params[:operation_name] = nil
        post :create, {:fp_auth_rule => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested fp_auth_rule" do
        fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "App01")
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_auth_rule.id, :fp_auth_rule => params}
        fp_auth_rule.reload
        fp_auth_rule.operation_name.should == "App02"
      end

      it "assigns the requested fp_auth_rule as @fp_auth_rule" do
        fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "App01")
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_auth_rule.to_param, :fp_auth_rule => params}
        assigns(:fp_auth_rule).should eq(fp_auth_rule)
      end

      it "redirects to the fp_auth_rule" do
        fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "App01")
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_auth_rule.to_param, :fp_auth_rule => params}
        response.should redirect_to(fp_auth_rule)
      end

      it "should raise error when tried to update at same time by many" do
        fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "App01")
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = "App02"
        fp_auth_rule2 = fp_auth_rule
        put :update, {:id => fp_auth_rule.id, :fp_auth_rule => params}
        fp_auth_rule.reload
        fp_auth_rule.operation_name.should == "App02"
        params[:operation_name] = "App03"
        put :update, {:id => fp_auth_rule2.id, :fp_auth_rule => params}
        fp_auth_rule.reload
        fp_auth_rule.operation_name.should == "App02"
        flash[:alert].should  match(/Someone edited the rule the same time you did. Please re-apply your changes to the rule/)
      end
    end

    describe "with invalid params" do
      it "assigns the fp_auth_rule as @fp_auth_rule" do
        fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "CUST01")
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = nil
        put :update, {:id => fp_auth_rule.to_param, :fp_auth_rule => params}
        assigns(:fp_auth_rule).should eq(fp_auth_rule)
        fp_auth_rule.reload
        params[:operation_name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        fp_auth_rule = Factory(:fp_auth_rule)
        params = fp_auth_rule.attributes.slice(*fp_auth_rule.class.attribute_names)
        params[:operation_name] = nil
        put :update, {:id => fp_auth_rule.id, :fp_auth_rule => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested fp_auth_rule as @fp_auth_rule" do
      fp_auth_rule = Factory(:fp_auth_rule)
      get :audit_logs, {:id => fp_auth_rule.id, :version_id => 0}
      assigns(:fp_auth_rule).should eq(fp_auth_rule)
      assigns(:audit).should eq(fp_auth_rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:fp_auth_rule).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      fp_auth_rule1 = Factory(:fp_auth_rule, :operation_name => "App01", :approval_status => 'A')
      fp_auth_rule2 = Factory(:fp_auth_rule, :operation_name => "App01", :approval_status => 'U', :approved_version => fp_auth_rule1.lock_version, :approved_id => fp_auth_rule1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      fp_auth_rule1.approval_status.should == 'A'
      FpUnapprovedRecord.count.should == 1
      put :approve, {:id => fp_auth_rule2.id}
      FpUnapprovedRecord.count.should == 0
      fp_auth_rule1.reload
      fp_auth_rule1.updated_by.should == "666"
      FpAuthRule.find_by_id(fp_auth_rule2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      fp_auth_rule = Factory(:fp_auth_rule, :operation_name => "App01", :approval_status => 'U')
      FpUnapprovedRecord.count.should == 1
      put :approve, {:id => fp_auth_rule.id}
      FpUnapprovedRecord.count.should == 0
      fp_auth_rule.reload
      fp_auth_rule.operation_name.should == 'App01'
      fp_auth_rule.approval_status.should == 'A'
    end
  end
end
