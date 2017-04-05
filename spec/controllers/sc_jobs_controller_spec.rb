require 'spec_helper'

describe ScJobsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "should assign all sc_jobs as @sc_jobs" do
      sc_job = Factory(:sc_job)
      get :index
      assigns(:sc_jobs).should eq([sc_job])
    end
  end

  describe "GET show" do
    it "should assign the requested sc_job as @sc_job" do
      sc_job = Factory(:sc_job)
      get :show, {:id => sc_job.id}
      assigns(:sc_job).should eq(sc_job)
    end
  end
  
  describe "PUT run" do
    it "should update run_now field of the requested sc_job as Y" do
      sc_job = Factory(:sc_job, run_now: 'N')
      put :run, {:id => sc_job.id}
      sc_job.reload
      sc_job.run_now.should == 'Y'
    end
  end
  
  describe "PUT pause" do
    it "should update paused field of the requested sc_job as Y" do
      sc_job = Factory(:sc_job, paused: 'N')
      put :pause, {:id => sc_job.id}
      sc_job.reload
      sc_job.paused.should == 'Y'
    end
  end
end
