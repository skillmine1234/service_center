require 'spec_helper'
require "cancan_matcher"

describe InwRemittanceRulesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET show" do
    it "assigns the requested rule as @rule" do
      rule = Factory(:inw_remittance_rule)
      get :show, {:id => rule.id}
      assigns(:rule).should eq(rule)
    end
  end

  describe "GET edit" do
    it "assigns the requested rule as @rule" do
      rule = Factory(:inw_remittance_rule)
      get :edit, {:id => rule.id}
      assigns(:rule).should eq(rule)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rule" do
        rule = Factory(:inw_remittance_rule, :pattern_individuals => "11")
        params = rule.attributes.slice(*rule.class.attribute_names)
        params[:pattern_individuals] = "15"
        put :update, {:id => rule.id, :inw_remittance_rule => params}
        rule.reload
        rule.pattern_individuals.should == "15"
      end

      it "assigns the requested rule as @rule" do
        rule = Factory(:inw_remittance_rule, :pattern_individuals => "11")
        params = rule.attributes.slice(*rule.class.attribute_names)
        params[:pattern_individuals] = "15"
        put :update, {:id => rule.to_param, :inw_remittance_rule => params}
        assigns(:rule).should eq(rule)
      end

      it "redirects to the rule" do
        rule = Factory(:inw_remittance_rule, :pattern_individuals => "11")
        params = rule.attributes.slice(*rule.class.attribute_names)
        params[:pattern_individuals] = "15"
        put :update, {:id => rule.to_param, :inw_remittance_rule => params}
        response.should redirect_to(rule)
      end

      it "should raise error when tried to update at same time by many" do
        rule = Factory(:inw_remittance_rule, :pattern_individuals => "11")
        params = rule.attributes.slice(*rule.class.attribute_names)
        params[:pattern_individuals] = "15"
        rule2 = rule
        put :update, {:id => rule.id, :inw_remittance_rule => params}
        rule.reload
        rule.pattern_individuals.should == "15"
        params[:pattern_individuals] = "18"
        put :update, {:id => rule2.id, :inw_remittance_rule => params}
        rule.reload
        rule.pattern_individuals.should == "15"
        flash[:alert].should  match(/Someone edited the rule the same time you did. Please re-apply your changes to the rule/)
      end
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested rule as @rule" do
      rule = Factory(:inw_remittance_rule)
      get :audit_logs, {:id => rule.id, :version_id => 0}
      assigns(:rule).should eq(rule)
      assigns(:audit).should eq(rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:rule).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end
