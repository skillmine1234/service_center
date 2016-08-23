require 'spec_helper'

describe OutgoingFilesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all outgoing_file as @outgoing_files" do
      outgoing_file = Factory(:outgoing_file)
      get :index, {:sc_service => outgoing_file.service_code}
      assigns(:outgoing_files).should eq([outgoing_file])
      assigns(:files_count).should eq(1)
    end
  end
end
