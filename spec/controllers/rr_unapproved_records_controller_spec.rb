require 'spec_helper'

describe RrUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all rr_unapproved_records as @rr_unapproved_records" do
      rr_unapproved_record = Factory(:rr_unapproved_record, :rr_approvable_type => 'IncomingFile')
      get :index
      assigns(:records).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
    end
  end
end