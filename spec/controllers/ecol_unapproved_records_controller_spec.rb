require 'spec_helper'

describe EcolUnapprovedRecordsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ecol_unapproved_records as @ecol_unapproved_records" do
      ecol_unapproved_record = Factory(:ecol_unapproved_record, :ecol_approvable_type => 'EcolRule')
      get :index
      assigns(:records).should eq([{:record_type=>"EcolCustomer", :record_count=>0}, {:record_type=>"EcolRemitter", :record_count=>0}, {:record_type=>"UdfAttribute", :record_count=>0}, {:record_type=>"EcolRule", :record_count=>1},{:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end
