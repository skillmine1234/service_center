require 'spec_helper'

describe Pc2UnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all pc2_unapproved_records as @pc2_unapproved_records" do
      pc2_unapproved_record = Factory(:pc2_unapproved_record, :pc2_approvable_type => 'Pc2App')
      get :index
      assigns(:records).should eq([{:record_type=>"Pc2App", :record_count=>1}, {:record_type=>"Pc2CustAccount", :record_count=>0}])
    end
  end
end
