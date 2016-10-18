require 'spec_helper'

describe ScUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all sc_unapproved_records as @sc_unapproved_records" do
      sc_unapproved_record = Factory(:sc_unapproved_record, :sc_approvable_type => 'ScBackend')
      get :index
      assigns(:records).should eq([{:record_type=>"ScBackend", :record_count=>1}])
    end
  end
end
