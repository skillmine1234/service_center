require 'spec_helper'

describe CnUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all cn_unapproved_records as @cn_unapproved_records" do
      cn_unapproved_record = Factory(:cn_unapproved_record, :cn_approvable_type => 'IncomingFile')
      p cn_unapproved_record
      get :index
      assigns(:records).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
    end
  end
end