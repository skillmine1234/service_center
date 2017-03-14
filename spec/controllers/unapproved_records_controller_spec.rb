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
      unapproved_record = Factory(:unapproved_record, :approvable_type => 'IncomingFile')
      get :index
      assigns(:records).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
    end
  end
end
