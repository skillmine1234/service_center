require 'spec_helper'
require "cancan_matcher"

describe SuIncomingRecordsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all su_incoming_record as @su_incoming_record" do
      su_incoming_record = Factory(:su_incoming_record)
      get :index, :file_name => su_incoming_record.file_name, :status => 'FAILED'
      assigns(:records).should eq([su_incoming_record])
      assigns(:records_count).should eq(1)
    end
  end

  describe "GET show" do
    it "assigns one su_incoming_record as @su_incoming_record" do
      su_incoming_record = Factory(:su_incoming_record)
      get :show, :id => su_incoming_record.id
      assigns(:su_record).should eq(su_incoming_record)
    end
  end

  describe "GET audit_steps" do
    it "assigns all audit_steps as @su_record_values" do
      su_incoming_record = Factory(:su_incoming_record)
      a = Factory(:fm_audit_step, :auditable => su_incoming_record)
      get :audit_steps, :id => su_incoming_record.id, :step_name => "ALL"
      assigns(:su_record_values).should eq([a])
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested su_incoming_record as @su_incoming_record" do
      su_incoming_record = Factory(:su_incoming_record)
      get :audit_logs, {:id => su_incoming_record.incoming_file_record_id, :version_id => 0}
      assigns(:record).should eq(su_incoming_record.incoming_file_record)
      assigns(:audit).should eq(su_incoming_record.incoming_file_record.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT update_multiple" do
    it "updates the requested records as skipped" do
      record = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'N', :overrides => nil))
      params = record.attributes.slice(*record.class.attribute_names)
      put :update_multiple, {:record_ids => [record.id], :status => 'skip'}
      response.should be_redirect
      record.incoming_file_record.reload
      record.incoming_file_record.should_skip.should == "Y"
    end

    it "updates the requested records as skipped" do
      record = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'N', :overrides => nil, :fault_code => "ns:W343"))
      params = record.attributes.slice(*record.class.attribute_names)
      put :update_multiple, {:record_ids => [record.id], :status => 'override'}
      response.should be_redirect
      record.incoming_file_record.reload
      record.incoming_file_record.overrides.should == record.incoming_file_record.fault_code
    end
  end
end