require 'spec_helper'

describe UnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all unapproved_records as @unapproved_records" do
      incoming_file1 = Factory(:incoming_file, :service_name => 'AML')
      incoming_file2 = Factory(:incoming_file, :service_name => 'ECOL')
      get :index, :sc_service => 'AML', :group_name => 'inward-remittance'
      assigns(:records).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
      partner = Factory(:partner)
      ecol_remitter = Factory(:ecol_remitter)
      get :index, :sc_service => 'AML', :group_name => 'inward-remittance'
      assigns(:records).should eq([{:record_type=>"IncomingFile", :record_count=>1},{:record_type=>"Partner", :record_count=>1}])
    end
  end
end
