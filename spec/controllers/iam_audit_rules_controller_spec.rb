require 'spec_helper'

describe IamAuditRulesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET show" do
    it "assigns the requested iam_audit_rule as @iam_audit_rule" do
      iam_audit_rule = Factory(:iam_audit_rule)
      get :show, {:id => iam_audit_rule.id}
      assigns(:iam_audit_rule).should eq(iam_audit_rule)
    end
  end

  describe "GET edit" do
    it "assigns the requested iam_audit_rule as @iam_audit_rule" do
      iam_audit_rule = Factory(:iam_audit_rule)
      get :edit, {:id => iam_audit_rule.id}
      assigns(:iam_audit_rule).should eq(iam_audit_rule)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested iam_audit_rule" do
        iam_audit_rule = Factory(:iam_audit_rule, :cert_dn => "Foo")
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = "Bar"
        put :update, {:id => iam_audit_rule.id, :iam_audit_rule => params}
        iam_audit_rule.reload
        iam_audit_rule.cert_dn.should == "Bar"
      end

      it "assigns the requested iam_audit_rule as @iam_audit_rule" do
        iam_audit_rule = Factory(:iam_audit_rule, :cert_dn => "Foo")
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = "Bar"
        put :update, {:id => iam_audit_rule.to_param, :iam_audit_rule => params}
        assigns(:iam_audit_rule).should eq(iam_audit_rule)
      end

      it "redirects to the iam_audit_rule" do
        iam_audit_rule = Factory(:iam_audit_rule, :cert_dn => "Foo")
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = "Bar"
        put :update, {:id => iam_audit_rule.to_param, :iam_audit_rule => params}
        response.should redirect_to(iam_audit_rule)
      end

      it "should raise error when tried to update at same time by many" do
        iam_audit_rule = Factory(:iam_audit_rule, :cert_dn => "Foo")
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = "Bar"
        iam_audit_rule2 = iam_audit_rule
        put :update, {:id => iam_audit_rule.id, :iam_audit_rule => params}
        iam_audit_rule.reload
        iam_audit_rule.cert_dn.should == "Bar"
        params[:cert_dn] = "Jim"
        put :update, {:id => iam_audit_rule2.id, :iam_audit_rule => params}
        iam_audit_rule.reload
        iam_audit_rule.cert_dn.should == "Bar"
        flash[:alert].should  match(/Someone edited the rule the same time you did. Please re-apply your changes to the rule./)
      end
    end

    describe "with invalid params" do
      it "assigns the iam_audit_rule as @iam_audit_rule" do
        iam_audit_rule = Factory(:iam_audit_rule, :cert_dn => "Foo")
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = nil
        put :update, {:id => iam_audit_rule.to_param, :iam_audit_rule => params}
        assigns(:iam_audit_rule).should eq(iam_audit_rule)
        iam_audit_rule.reload
        params[:cert_dn] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        iam_audit_rule = Factory(:iam_audit_rule)
        params = iam_audit_rule.attributes.slice(*iam_audit_rule.class.attribute_names)
        params[:cert_dn] = nil
        put :update, {:id => iam_audit_rule.id, :iam_audit_rule => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested iam_audit_rule as @iam_audit_rule" do
      iam_audit_rule = Factory(:iam_audit_rule)
      get :audit_logs, {:id => iam_audit_rule.id, :version_id => 0}
      assigns(:record).should eq(iam_audit_rule)
      assigns(:audit).should eq(iam_audit_rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end
