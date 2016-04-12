require 'spec_helper'
require "cancan_matcher"

describe IcIncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ic_incoming_record as @ic_incoming_record" do
      ic_incoming_record = Factory(:ic_incoming_record)
      get :index, :file_name => ic_incoming_record.file_name, :status => 'FAILED'
      assigns(:records).should eq([ic_incoming_record])
      assigns(:records_count).should eq(1)
    end
  end

  describe "GET show" do
    it "assigns one ic_incoming_record as @ic_incoming_record" do
      ic_incoming_record = Factory(:ic_incoming_record)
      get :show, :id => ic_incoming_record.id
      assigns(:ic_record).should eq(ic_incoming_record)
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested ic_incoming_record as @ic_incoming_record" do
      ic_incoming_record = Factory(:ic_incoming_record)
      get :audit_logs, {:id => ic_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(ic_incoming_record.incoming_file_record)
      assigns(:audit).should eq(ic_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT update_multiple" do
    it "updates the requested records as skipped" do
      record = Factory(:ic_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'N', :overrides => nil))
      params = record.attributes.slice(*record.class.attribute_names)
      put :update_multiple, {:record_ids => [record.id], :status => 'skip'}
      response.should be_redirect
      record.incoming_file_record.reload
      record.incoming_file_record.should_skip.should == "Y"
    end

    it "updates the requested records as skipped" do
      record = Factory(:ic_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'N', :overrides => nil, :fault_code => "ns:W343"))
      params = record.attributes.slice(*record.class.attribute_names)
      put :update_multiple, {:record_ids => [record.id], :status => 'override'}
      response.should be_redirect
      record.incoming_file_record.reload
      record.incoming_file_record.overrides.should == record.incoming_file_record.fault_code
    end
  end
end