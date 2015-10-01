require 'spec_helper'
require "cancan_matcher"

describe BmBillPaymentsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all bm_bill_payments as @bm_bill_payments" do
      bm_bill_payment = Factory(:bm_bill_payment)
      get :index
      assigns(:bm_bill_payments).should eq([bm_bill_payment])
    end
  end

  describe "GET show" do
    it "assigns the requested bm_bill_payment as @bm_bill_payment" do
      bm_bill_payment = Factory(:bm_bill_payment)
      get :show, {:id => bm_bill_payment.id}
      assigns(:bill_payment).should eq(bm_bill_payment)
    end
  end
end