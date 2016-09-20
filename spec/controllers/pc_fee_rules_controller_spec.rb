require 'spec_helper'

describe PcFeeRulesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc_fee_rules as @pc_fee_rules" do
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'A')
      get :index
      assigns(:pc_fee_rules).should eq([pc_fee_rule])
    end
    
    it "assigns all unapproved pc_fee_rules as @pc_fee_rules when approval_status is passed" do
      pc_fee_rule = Factory(:pc_fee_rule)
      get :index, :approval_status => 'U'
      assigns(:pc_fee_rules).should eq([pc_fee_rule])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc_fee_rule as @pc_fee_rule" do
      pc_fee_rule = Factory(:pc_fee_rule)
      get :show, {:id => pc_fee_rule.id}
      assigns(:pc_fee_rule).should eq(pc_fee_rule)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc_fee_rule as @pc_fee_rule" do
      get :new
      assigns(:pc_fee_rule).should be_a_new(PcFeeRule)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc_fee_rule with status 'U' as @pc_fee_rule" do
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'U')
      get :edit, {:id => pc_fee_rule.id}
      assigns(:pc_fee_rule).should eq(pc_fee_rule)
    end

    it "assigns the requested pc_fee_rule with status 'A' as @pc_fee_rule" do
      pc_fee_rule = Factory(:pc_fee_rule,:approval_status => 'A')
      get :edit, {:id => pc_fee_rule.id}
      assigns(:pc_fee_rule).should eq(pc_fee_rule)
    end

    it "assigns the new pc_fee_rule with requested pc_fee_rule params when status 'A' as @pc_fee_rule" do
      pc_fee_rule = Factory(:pc_fee_rule,:approval_status => 'A')
      params = (pc_fee_rule.attributes).merge({:approved_id => pc_fee_rule.id,:approved_version => pc_fee_rule.lock_version})
      get :edit, {:id => pc_fee_rule.id}
      assigns(:pc_fee_rule).should eq(PcFeeRule.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc_fee_rule" do
        params = Factory.attributes_for(:pc_fee_rule)
        expect {
          post :create, {:pc_fee_rule => params}
        }.to change(PcFeeRule.unscoped, :count).by(1)
        flash[:alert].should  match(/PcFeeRule successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created pc_fee_rule as @pc_fee_rule" do
        params = Factory.attributes_for(:pc_fee_rule)
        post :create, {:pc_fee_rule => params}
        assigns(:pc_fee_rule).should be_a(PcFeeRule)
        assigns(:pc_fee_rule).should be_persisted
      end

      it "redirects to the created pc_fee_rule" do
        params = Factory.attributes_for(:pc_fee_rule)
        post :create, {:pc_fee_rule => params}
        response.should redirect_to(PcFeeRule.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc_fee_rule as @pc_fee_rule" do
        params = Factory.attributes_for(:pc_fee_rule)
        params[:product_code] = nil
        expect {
          post :create, {:pc_fee_rule => params}
        }.to change(PcFeeRule, :count).by(0)
        assigns(:pc_fee_rule).should be_a(PcFeeRule)
        assigns(:pc_fee_rule).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc_fee_rule)
        params[:product_code] = nil
        post :create, {:pc_fee_rule => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc_fee_rule" do
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:tier1_to_amt] = 1000
        put :update, {:id => pc_fee_rule.id, :pc_fee_rule => params}
        pc_fee_rule.reload
        pc_fee_rule.tier1_to_amt.should == 1000
      end

      it "assigns the requested pc_fee_rule as @pc_fee_rule" do
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:tier1_to_amt] = 1000
        put :update, {:id => pc_fee_rule.to_param, :pc_fee_rule => params}
        assigns(:pc_fee_rule).should eq(pc_fee_rule)
      end

      it "redirects to the pc_fee_rule" do
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:tier1_to_amt] = 1000
        put :update, {:id => pc_fee_rule.to_param, :pc_fee_rule => params}
        response.should redirect_to(pc_fee_rule)
      end

      it "should raise error when tried to update at same time by many" do
        pc_program = Factory(:pc_program)
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:tier1_to_amt] = 1000
        pc_fee_rule2 = pc_fee_rule
        put :update, {:id => pc_fee_rule.id, :pc_fee_rule => params}
        pc_fee_rule.reload
        pc_fee_rule.tier1_to_amt.should == 1000
        params[:tier1_to_amt] = 2000
        put :update, {:id => pc_fee_rule2.id, :pc_fee_rule => params}
        pc_fee_rule.reload
        pc_fee_rule.tier1_to_amt.should == 1000
        flash[:alert].should  match(/Someone edited the pc_fee_rule the same time you did. Please re-apply your changes to the pc_fee_rule/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc_fee_rule as @pc_fee_rule" do
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:product_code] = nil
        put :update, {:id => pc_fee_rule.to_param, :pc_fee_rule => params}
        assigns(:pc_fee_rule).should eq(pc_fee_rule)
        pc_fee_rule.reload
        params[:product_code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc_fee_rule = Factory(:pc_fee_rule)
        params = pc_fee_rule.attributes.slice(*pc_fee_rule.class.attribute_names)
        params[:product_code] = nil
        put :update, {:id => pc_fee_rule.id, :pc_fee_rule => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc_fee_rule as @pc_fee_rule" do
      pc_fee_rule = Factory(:pc_fee_rule)
      get :audit_logs, {:id => pc_fee_rule.id, :version_id => 0}
      assigns(:pc_fee_rule).should eq(pc_fee_rule)
      assigns(:audit).should eq(pc_fee_rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:pc_fee_rule).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      p PcUnapprovedRecord.all
      p PcUnapprovedRecord.count
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_fee_rule1 = Factory(:pc_fee_rule, :approval_status => 'A')
      pc_fee_rule2 = Factory(:pc_fee_rule, :approval_status => 'U', :tier1_to_amt => 10000, :approved_version => pc_fee_rule1.lock_version, :approved_id => pc_fee_rule1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      pc_fee_rule1.approval_status.should == 'A'
      p PcUnapprovedRecord.all
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_fee_rule2.id}
      PcUnapprovedRecord.count.should == 0
      pc_fee_rule1.reload
      pc_fee_rule1.tier1_to_amt.should == 10000
      pc_fee_rule1.updated_by.should == "666"
      PcFeeRule.find_by_id(pc_fee_rule2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'U', :tier1_to_amt => 10000)
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_fee_rule.id}
      PcUnapprovedRecord.count.should == 0
      pc_fee_rule.reload
      pc_fee_rule.tier1_to_amt.should == 10000
      pc_fee_rule.approval_status.should == 'A'
    end
  end

end
