require 'spec_helper'

describe EcolRulesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET show" do
    it "assigns the requested rule as @ecol_rule" do
      ecol_rule = Factory(:ecol_rule)
      get :show, {:id => ecol_rule.id}
      assigns(:ecol_rule).should eq(ecol_rule)
    end
  end
  
  describe "GET edit" do
    it "assigns the requested rule as @ecol_rule" do
      ecol_rule = Factory(:ecol_rule)
      get :edit, {:id => ecol_rule.id}
      assigns(:ecol_rule).should eq(ecol_rule)
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rule" do
        ecol_rule = Factory(:ecol_rule, :ifsc => "ABCD0QWERTY")
        params = ecol_rule.attributes.slice(*ecol_rule.class.attribute_names)
        params[:ifsc] = "CDAB0QWERTY"
        put :update, {:id => ecol_rule.id, :ecol_rule => params}
        ecol_rule.reload
        ecol_rule.ifsc.should == "CDAB0QWERTY"
      end

      it "assigns the requested rule as @ecol_rule" do
        ecol_rule = Factory(:ecol_rule, :ifsc => "ABCD0QWERTY")
        params = ecol_rule.attributes.slice(*ecol_rule.class.attribute_names)
        params[:ifsc] = "CDAB0QWERTY"
        put :update, {:id => ecol_rule.to_param, :ecol_rule => params}
        assigns(:ecol_rule).should eq(ecol_rule)
      end

      it "redirects to the rule" do
        ecol_rule = Factory(:ecol_rule, :ifsc => "ABCD0QWERTY")
        params = ecol_rule.attributes.slice(*ecol_rule.class.attribute_names)
        params[:ifsc] = "CDAB0QWERTY"
        put :update, {:id => ecol_rule.to_param, :ecol_rule => params}
        response.should redirect_to(ecol_rule)
      end

      it "should raise error when tried to update at same time by many" do
        ecol_rule = Factory(:ecol_rule, :ifsc => "ORGV0123456")
        
        # update once
        params = ecol_rule.attributes.slice(*ecol_rule.class.attribute_names)
        params[:ifsc] = "UPDA0123456"
        put :update, {:id => ecol_rule.id, :ecol_rule => params}

        # update another time, without a reload, this will fail as the lock_version has changed 
        params = ecol_rule.attributes.slice(*ecol_rule.class.attribute_names)
        params[:ifsc] = "UPDB0123456"
        put :update, {:id => ecol_rule.id, :ecol_rule => params}
        flash[:alert].should  match(/Someone edited the rule the same time you did. Please re-apply your changes to the rule/)
      end
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested rule as @ecol_rule" do
      ecol_rule = Factory(:ecol_rule)
      get :audit_logs, {:id => ecol_rule.id, :version_id => 0}
      assigns(:ecol_rule).should eq(ecol_rule)
      assigns(:audit).should eq(ecol_rule.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "e"}
      assigns(:ecol_rule).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET error_msg" do
    it "displays the flash msg and redirects to root" do
      ecol_rule = Factory(:ecol_rule)
      get :error_msg
      flash[:alert].should  match(/Rule is not yet configured/)
      response.should redirect_to(:root)
    end
  end

end
