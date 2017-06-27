require 'spec_helper'

describe ImtRulesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET new" do
    it "assigns a new imt_rule as @imt_rule" do
      get :new
      assigns(:imt_rule).should be_a_new(ImtRule)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new imt_rule" do
        params = Factory.attributes_for(:imt_rule)
        expect {
          post :create, {:imt_rule => params}
        }.to change(ImtRule.unscoped, :count).by(1)
        flash[:alert].should  match(/Rule successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created imt_rule as @imt_rule" do
        params = Factory.attributes_for(:imt_rule)
        post :create, {:imt_rule => params}
        assigns(:imt_rule).should be_a(ImtRule)
        assigns(:imt_rule).should be_persisted
      end

      it "redirects to the created imt_rule" do
        params = Factory.attributes_for(:imt_rule)
        post :create, {:imt_rule => params}
        response.should redirect_to(ImtRule.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved imt_rule as @imt_rule" do
        params = Factory.attributes_for(:imt_rule)
        params[:stl_gl_account] = nil
        expect {
          post :create, {:imt_rule => params}
        }.to change(ImtRule, :count).by(0)
        assigns(:imt_rule).should be_a(ImtRule)
        assigns(:imt_rule).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:imt_rule)
        params[:stl_gl_account] = nil
        post :create, {:imt_rule => params}
        response.should render_template("new")
      end
    end
  end

  describe "GET index" do
    it "assigns all imt_rules with approval_status 'U' as @imt_rules" do
      imt_rule1 = Factory(:imt_rule, :approval_status => 'A')
      imt_rule2 = Factory(:imt_rule, :approval_status => 'U')
      get :index
      assigns(:imt_rules).should eq([imt_rule2])
    end
  end

  describe "GET show" do
    it "assigns the requested rule as @imt_rule" do
      imt_rule = Factory(:imt_rule)
      get :show, {:id => imt_rule.id}
      assigns(:imt_rule).should eq(imt_rule)
    end
  end
  
  describe "GET edit" do
    it "assigns the requested rule as @imt_rule" do
      imt_rule = Factory(:imt_rule)
      get :edit, {:id => imt_rule.id}
      assigns(:imt_rule).should eq(imt_rule)
    end

    it "assigns the requested imt_rule with status 'A' as @imt_rule" do
      imt_rule = Factory(:imt_rule,:approval_status => 'A')
      get :edit, {:id => imt_rule.id}
      assigns(:imt_rule).should eq(imt_rule)
    end

    it "assigns the new imt_rule with requested imt_rule params when status 'A' as @imt_rule" do
      imt_rule = Factory(:imt_rule,:approval_status => 'A')
      params = (imt_rule.attributes).merge({:approved_id => imt_rule.id,:approved_version => imt_rule.lock_version})
      get :edit, {:id => imt_rule.id}
      assigns(:imt_rule).should eq(ImtRule.new(params))
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rule" do
        imt_rule = Factory(:imt_rule, :stl_gl_account => "1134567890")
        params = imt_rule.attributes.slice(*imt_rule.class.attribute_names)
        params[:stl_gl_account] = "1134567891"
        put :update, {:id => imt_rule.id, :imt_rule => params}
        imt_rule.reload
        imt_rule.stl_gl_account.should == "1134567891"
      end

      it "assigns the requested rule as @imt_rule" do
        imt_rule = Factory(:imt_rule, :stl_gl_account => "1134567890")
        params = imt_rule.attributes.slice(*imt_rule.class.attribute_names)
        params[:stl_gl_account] = "1134567891"
        put :update, {:id => imt_rule.to_param, :imt_rule => params}
        assigns(:imt_rule).should eq(imt_rule)
      end

      it "redirects to the rule" do
        imt_rule = Factory(:imt_rule, :stl_gl_account => "1134567890")
        params = imt_rule.attributes.slice(*imt_rule.class.attribute_names)
        params[:stl_gl_account] = "1134567891"
        put :update, {:id => imt_rule.to_param, :imt_rule => params}
        response.should redirect_to(imt_rule)
      end

      it "should raise error when tried to update at same time by many" do
        imt_rule = Factory(:imt_rule, :stl_gl_account => "1134567890")
        
        # update once
        params = imt_rule.attributes.slice(*imt_rule.class.attribute_names)
        params[:stl_gl_account] = "1134567891"
        put :update, {:id => imt_rule.id, :imt_rule => params}

        # update another time, without a reload, this will fail as the lock_version has changed 
        params = imt_rule.attributes.slice(*imt_rule.class.attribute_names)
        params[:stl_gl_account] = "1134567892"
        put :update, {:id => imt_rule.id, :imt_rule => params}
        flash[:alert].should  match(/Someone edited the rule the same time you did. Please re-apply your changes to the rule/)
      end
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested rule as @imt_rule" do
      imt_rule = Factory(:imt_rule)
      get :audit_logs, {:id => imt_rule.id, :version_id => 0}
      assigns(:record).should eq(imt_rule)
      assigns(:audit).should eq(imt_rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "b"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET error_msg" do
    it "displays the flash msg and redirects to root" do
      imt_rule = Factory(:imt_rule)
      get :error_msg
      flash[:alert].should  match(/Rule is not yet configured/)
      response.should redirect_to(:root)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      imt_rule1 = Factory(:imt_rule, :approval_status => 'A')
      imt_rule2 = Factory(:imt_rule, :approval_status => 'U', :stl_gl_account => '09789654321', :approved_version => imt_rule1.lock_version, :approved_id => imt_rule1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      imt_rule1.approval_status.should == 'A'
      ImtUnapprovedRecord.count.should == 1
      put :approve, {:id => imt_rule2.id}
      ImtUnapprovedRecord.count.should == 0
      imt_rule1.reload
      imt_rule1.stl_gl_account.should == '09789654321'
      imt_rule1.updated_by.should == "666"
      ImtRule.find_by_id(imt_rule2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      imt_rule = Factory(:imt_rule, :stl_gl_account => '09789654321', :approval_status => 'U')
      ImtUnapprovedRecord.count.should == 1
      put :approve, {:id => imt_rule.id}
      ImtUnapprovedRecord.count.should == 0
      imt_rule.reload
      imt_rule.stl_gl_account.should == '09789654321'
      imt_rule.approval_status.should == 'A'
    end
  end
end
