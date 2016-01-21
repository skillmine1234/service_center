require 'spec_helper'

describe ImtUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all imt_unapproved_records as @imt_unapproved_records" do
      imt_unapproved_record = Factory(:imt_unapproved_record, :imt_approvable_type => 'ImtCustomer')
      get :index
      assigns(:records).should eq([{:record_type=>"ImtCustomer", :record_count=>1}, {:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end
