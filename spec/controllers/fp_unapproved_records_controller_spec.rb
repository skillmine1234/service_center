require 'spec_helper'

describe FpUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all fp_unapproved_records as @fp_unapproved_records" do
      fp_unapproved_record = Factory(:fp_unapproved_record, :fp_approvable_type => 'FpOperation')
      get :index
      assigns(:records).should eq([{:record_type=>"FpOperation", :record_count=>1}, {:record_type=>"FpAuthRule", :record_count=>0}])
    end
  end
end
