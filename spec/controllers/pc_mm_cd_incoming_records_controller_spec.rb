require 'spec_helper'
require "cancan_matcher"

describe PcMmCdIncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all pc_mm_cd_incoming_record as @pc_mm_cd_incoming_record" do
      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record)
      get :index, :file_name => pc_mm_cd_incoming_record.file_name, :status => 'FAILED'
      assigns(:records).should eq([pc_mm_cd_incoming_record])
      assigns(:records_count).should eq(1)
    end
  end

  describe "GET show" do
    it "assigns one pc_mm_cd_incoming_record as @pc_mm_cd_incoming_record" do
      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record)
      get :show, :id => pc_mm_cd_incoming_record.id
      assigns(:pc_record).should eq(pc_mm_cd_incoming_record)
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested pc_mm_cd_incoming_record as @pc_mm_cd_incoming_record" do
      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record)
      get :audit_logs, {:id => pc_mm_cd_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(pc_mm_cd_incoming_record.incoming_file_record)
      assigns(:audit).should eq(pc_mm_cd_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "GET incoming_file_summary" do
    it "assigns one pc_mm_cd_incoming_file as @summary" do
      pc_mm_cd_incoming_file = Factory(:pc_mm_cd_incoming_file)
      get :incoming_file_summary, :file_name => pc_mm_cd_incoming_file.file_name
      assigns(:summary).should eq(pc_mm_cd_incoming_file)
    end
  end
end