require 'spec_helper'

describe SuUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all su_unapproved_records as @su_unapproved_records" do
      su_unapproved_record = Factory(:su_unapproved_record, :su_approvable_type => 'SuCustomer')
      get :index
      assigns(:records).should eq([{:record_type=>"SuCustomer", :record_count=>1}])
    end
  end
end
