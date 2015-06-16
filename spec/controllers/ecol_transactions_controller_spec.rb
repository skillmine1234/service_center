require 'spec_helper'

describe EcolTransactionsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all ecol_transactions as @ecol_transactions" do
      ecol_transaction = Factory(:ecol_transaction)
      get :index
      assigns(:ecol_transactions).should eq([ecol_transaction])
    end
  end
  
  describe "GET show" do
    it "assigns the requested ecol_transaction as @ecol_transaction" do
      ecol_transaction = Factory(:ecol_transaction)
      get :show, {:id => ecol_transaction.id}
      assigns(:ecol_transaction).should eq(ecol_transaction)
    end
  end

end
