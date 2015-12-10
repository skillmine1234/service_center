require 'spec_helper'

describe PcUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all pc_unapproved_records as @pc_unapproved_records" do
      pc_unapproved_record = Factory(:pc_unapproved_record, :pc_approvable_type => 'PcApp')
      get :index
      assigns(:records).should eq([{:record_type=>"PcApp", :record_count=>1}, {:record_type=>"PcFeeRule", :record_count=>0}])
    end
  end
end
