require 'spec_helper'

describe IamAuditLogsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all iam_audit_logs as @iam_audit_logs" do
      iam_audit_log = Factory(:iam_audit_log)
      get :index
      assigns(:records).should eq([iam_audit_log])
    end
  end
  
  describe "GET show" do
    it "assigns the requested ic_invoice as @iam_audit_logs" do
      iam_audit_log = Factory(:iam_audit_log)
      get :show, {:id => iam_audit_log.id}
      assigns(:iam_audit_log).should eq(iam_audit_log)
    end
  end

end
