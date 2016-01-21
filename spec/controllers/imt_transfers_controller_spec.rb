require 'spec_helper'

describe ImtTransfersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all imt_transfers as @imt_transfers" do
      imt_transfer = Factory(:imt_transfer)
      get :index
      assigns(:imt_transfers).should eq([imt_transfer])
    end
  end
  
  describe "GET show" do
    it "assigns the requested imt_transfer as @imt_transfer" do
      imt_transfer = Factory(:imt_transfer)
      get :show, {:id => imt_transfer.id}
      assigns(:imt_transfer).should eq(imt_transfer)
    end
  end

end
