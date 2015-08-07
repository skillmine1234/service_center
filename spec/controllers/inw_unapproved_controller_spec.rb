require 'spec_helper'

describe InwUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all inw_unapproved_records as @inw_unapproved_records" do
      inw_unapproved_record = Factory(:inw_unapproved_record, :inw_approvable_type => 'Bank')
      get :index
      assigns(:records).should eq([{:record_type=>"Partner", :record_count=>0},{:record_type=>"Bank", :record_count=>1},{:record_type=>"PurposeCode", :record_count=>0},{:record_type=>"WhitelistedIdentity", :record_count=>0},{:record_type=>"InwRemittanceRule", :record_count=>0}])
    end
  end
end