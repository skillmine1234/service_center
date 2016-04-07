require 'spec_helper'

describe IcUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ic_unapproved_records as @ic_unapproved_records" do
      ic_unapproved_record = Factory(:ic_unapproved_record, :ic_approvable_type => 'IcCustomer')
      get :index
      assigns(:records).should eq([{:record_type=>"IcCustomer", :record_count=>1}, {:record_type=>"IcSupplier", :record_count=>0}])
    end
  end
end
