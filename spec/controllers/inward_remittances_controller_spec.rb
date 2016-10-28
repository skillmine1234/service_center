require 'spec_helper'
require "cancan_matcher"

describe InwardRemittancesController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all inward_remittances as @inward_remittances" do
      inward_remittance = Factory(:inward_remittance)
      get :index
      assigns(:inward_remittances).should eq([inward_remittance])
    end    

    it "assigns all inward_remittances with particular request_no" do
      inward_remittance = Factory(:inward_remittance)
      get :index, {:req_no => inward_remittance.req_no}
      assigns(:inward_remittances).should eq([inward_remittance])
    end
    
    it "assigns all inward_remittances with highest attempt_no for particular request_no" do
      inward_remittances = [Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 4, :partner_code => "PARTNER1")]
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 2, :partner_code => "PARTNER1")
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 3, :partner_code => "PARTNER1")
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0112", :attempt_no => 1, :partner_code => "PARTNER2")
      
      inward_remittances_with_max_attempt = [inward_remittances[0]]
      inward_remittances_with_max_attempt << inward_remittances[3]
            
      get :index
      expect(assigns(:inward_remittances)).to match_array(inward_remittances_with_max_attempt)
    end

    it "assigns all inward_remittances with highest attempt_no for particular request_no on advanced search" do
      inward_remittances = [Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 4, :partner_code => "PARTNER1")]
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 2, :partner_code => "PARTNER1")
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0114", :attempt_no => 3, :partner_code => "PARTNER1")
      inward_remittances << Factory(:inward_remittance, :req_no => "TT0112", :attempt_no => 1, :partner_code => "PARTNER2")
      
      inward_remittances_with_max_attempt = [inward_remittances[0]]
            
      get :index, :advanced_search => true, :request_no => 'TT0114'
      expect(assigns(:inward_remittances)).to match_array(inward_remittances_with_max_attempt)
    end
    
    it "assigns all inward_remittances in descending order of id" do
     inward_remittances = [Factory(:inward_remittance, :req_no => "TT0222", :attempt_no => 1, :partner_code => "PARTNER1")]
     inward_remittances << Factory(:inward_remittance, :req_no => "TT0223", :attempt_no => 1, :partner_code => "PARTNER1")
     inward_remittances << Factory(:inward_remittance, :req_no => "TT0224", :attempt_no => 1, :partner_code => "PARTNER1")
       
     inward_remittances_with_proper_order = [inward_remittances[2]]
     inward_remittances_with_proper_order << inward_remittances[1]
     inward_remittances_with_proper_order << inward_remittances[0]
         
     get :index
     expect(assigns(:inward_remittances)).to match_array(inward_remittances_with_proper_order)
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

  describe "GET audit_logs" do
    it "assigns the requested inward_remittance as @inward_remittance" do
      inward_remittance = Factory(:inward_remittance, :partner_code => 20)
      inw_audit_log = Factory(:inw_audit_step, :inw_auditable_type => 'InwardRemittance', :inw_auditable_id => inward_remittance.id)
      get :audit_logs, {:id => inward_remittance.id, :step_name => 'ALL'}
      assigns(:values_count).should eq(1)
      assigns(:values).should eq([inw_audit_log])
    end
  end
end
