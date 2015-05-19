require 'spec_helper'
require "cancan_matcher"

describe InwardRemittancesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all inward_remittances as @inward_remittances" do
      inward_remittance = Factory(:inward_remittance)
      get :index
      assigns(:inward_remittances).should eq([inward_remittance])
    end
  end

  describe "GET show" do
    it "assigns the requested inward_remittance as @inward_remittance" do
      inward_remittance = Factory(:inward_remittance)
      get :show, {:id => inward_remittance.id}
      assigns(:inward_remittance).should eq(inward_remittance)
    end
  end

  describe "GET remitter_identities" do 
    it "assigns the remitter_identities as @identities" do 
      inward_remittance = Factory(:inward_remittance)
      Factory(:inw_identity, :inw_remittance_id => inward_remittance.id, :id_for => 'R')
      get :remitter_identities, {:id => inward_remittance.id}
      assigns(:identities).first.should eq(inward_remittance.remitter_identities.first)
    end
  end

  describe "GET beneficiary_identities" do 
    it "assigns the beneficiary_identities as @identities" do 
      inward_remittance = Factory(:inward_remittance)
      Factory(:inw_identity, :inw_remittance_id => inward_remittance.id, :id_for => 'B')
      get :beneficiary_identities, {:id => inward_remittance.id}
      assigns(:identities).first.should eq(inward_remittance.beneficiary_identities.first)
    end
  end
end
