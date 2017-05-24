require 'spec_helper'
require "cancan_matcher"

describe ImtIncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all imt_incoming_record as @imt_incoming_record" do
      imt_incoming_record = Factory(:imt_incoming_record)
      get :index, :file_name => imt_incoming_record.file_name, :status => 'FAILED'
      assigns(:records).should eq([imt_incoming_record])
    end
  end

  describe "GET show" do
    it "assigns one imt_incoming_record as @imt_incoming_record" do
      imt_incoming_record = Factory(:imt_incoming_record)
      get :show, :id => imt_incoming_record.id
      assigns(:imt_record).should eq(imt_incoming_record)
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested imt_incoming_record as @imt_incoming_record" do
      imt_incoming_record = Factory(:imt_incoming_record)
      get :audit_logs, {:id => imt_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(imt_incoming_record.incoming_file_record)
      assigns(:audit).should eq(imt_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET incoming_file_summary" do
    it "assigns one imt_incoming_file as @summary" do
      imt_incoming_file = Factory(:imt_incoming_file)
      get :incoming_file_summary, :file_name => imt_incoming_file.file_name
      assigns(:summary).should eq(imt_incoming_file)
    end
  end
end