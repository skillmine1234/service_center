require 'spec_helper'
require "cancan_matcher"

describe Cnb2IncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all cnb2_incoming_record as @cnb2_incoming_record" do
      cnb2_incoming_record = Factory(:cnb2_incoming_record)
      get :index, :file_name => cnb2_incoming_record.file_name, :status => 'FAILED'
      p response
      assigns(:records).should eq([cnb2_incoming_record])
      assigns(:records_count).should eq(1)
    end
  end

  describe "GET show" do
    it "assigns one cnb2_incoming_record as @cnb2_incoming_record" do
      cnb2_incoming_record = Factory(:cnb2_incoming_record)
      get :show, :id => cnb2_incoming_record.id
      assigns(:cnb2_record).should eq(cnb2_incoming_record)
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested cnb2_incoming_record as @cnb2_incoming_record" do
      cnb2_incoming_record = Factory(:cnb2_incoming_record)
      get :audit_logs, {:id => cnb2_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(cnb2_incoming_record.incoming_file_record)
      assigns(:audit).should eq(cnb2_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET incoming_file_summary" do
    it "assigns one cnb2_incoming_file as @summary" do
      cnb2_incoming_file = Factory(:cnb2_incoming_file)
      get :incoming_file_summary, :file_name => cnb2_incoming_file.file_name
      assigns(:summary).should eq(cnb2_incoming_file)
    end
  end
end