require 'spec_helper'
require "cancan_matcher"

describe Ic001IncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ic001_incoming_record as @ic001_incoming_record" do
      ic001_incoming_record = Factory(:ic001_incoming_record)
      get :index, :file_name => ic001_incoming_record.file_name, :status => 'FAILED'
      assigns(:records).should eq([ic001_incoming_record])
    end
  end

  describe "GET show" do
    it "assigns one ic001_incoming_record as @ic001_incoming_record" do
      ic001_incoming_record = Factory(:ic001_incoming_record)
      get :show, :id => ic001_incoming_record.id
      assigns(:ic_record).should eq(ic001_incoming_record)
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested ic001_incoming_record as @ic001_incoming_record" do
      ic001_incoming_record = Factory(:ic001_incoming_record)
      get :audit_logs, {:id => ic001_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(ic001_incoming_record.incoming_file_record)
      assigns(:audit).should eq(ic001_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET incoming_file_summary" do
    it "assigns one ic001_incoming_file as @summary" do
      ic001_incoming_file = Factory(:ic001_incoming_file)
      get :incoming_file_summary, :file_name => ic001_incoming_file.file_name
      assigns(:summary).should eq(ic001_incoming_file)
    end
  end
end