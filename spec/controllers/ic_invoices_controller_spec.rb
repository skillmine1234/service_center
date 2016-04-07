require 'spec_helper'

describe IcInvoicesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all ic_invoices as @ic_invoices" do
      ic_invoice = Factory(:ic_invoice)
      get :index
      assigns(:ic_invoices).should eq([ic_invoice])
    end
  end
  
  describe "GET show" do
    it "assigns the requested ic_invoice as @ic_invoice" do
      ic_invoice = Factory(:ic_invoice)
      get :show, {:id => ic_invoice.id}
      assigns(:ic_invoice).should eq(ic_invoice)
    end
  end

end
