require 'spec_helper'

describe RcAppsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET show" do
    it "assigns the requested rc_app as @rc_app" do
      rc_app = Factory(:rc_app)
      get :show, {:id => rc_app.id}
      assigns(:rc_app).should eq(rc_app)
    end
  end
  
  describe "GET index" do
    it "assigns all rc_apps as @rc_apps" do
      rc_app = Factory(:rc_app)
      get :index
      assigns(:rc_apps).should eq([rc_app])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested rc_app as @rc_app" do
      rc_app = Factory(:rc_app)
      get :edit, {:id => rc_app.id}
      assigns(:rc_app).should eq(rc_app)
    end
  end
  
  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested rc_app" do
  #       rc_app = Factory(:rc_app, :app_id => "APP123")
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = "APP000"
  #       put :update, {:id => rc_app.id, :rc_app => params}
  #       rc_app.reload
  #       rc_app.app_id.should == "APP000"
  #     end
  #
  #     it "assigns the requested rc_app as @rc_app" do
  #       rc_app = Factory(:rc_app, :app_id => "APP123")
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = "APP123"
  #       put :update, {:id => rc_app.to_param, :rc_app => params}
  #       assigns(:rc_app).should eq(rc_app)
  #     end
  #
  #     it "redirects to the rc_app" do
  #       rc_app = Factory(:rc_app, :app_id => "APP123")
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = "APP000"
  #       put :update, {:id => rc_app.to_param, :rc_app => params}
  #       response.should redirect_to(rc_app)
  #     end
  #
  #     it "should raise error when tried to update at same time by many" do
  #       rc_app = Factory(:rc_app, :app_id => "APP123")
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = "APP000"
  #       rc_app2 = rc_app
  #       put :update, {:id => rc_app.id, :rc_app => params}
  #       rc_app.reload
  #       rc_app.app_id.should == "APP000"
  #       params[:app_id] = "APP999"
  #       put :update, {:id => rc_app2.id, :rc_app => params}
  #       rc_app.reload
  #       rc_app.app_id.should == "APP000"
  #       flash[:alert].should  match(/Someone edited the rc_app the same time you did. Please re-apply your changes to the rc_app/)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the rc_app as @rc_app" do
  #       rc_app = Factory(:rc_app, :app_id => "APP123")
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = nil
  #       put :update, {:id => rc_app.to_param, :rc_app => params}
  #       assigns(:rc_app).should eq(rc_app)
  #       rc_app.reload
  #       params[:app_id] = nil
  #     end
  #
  #     it "re-renders the 'edit' template when show_errors is true" do
  #       rc_app = Factory(:rc_app)
  #       params = rc_app.attributes.slice(*rc_app.class.attribute_names)
  #       params[:app_id] = nil
  #       put :update, {:id => rc_app.id, :rc_app => params, :show_errors => "true"}
  #       response.should render_template("edit")
  #     end
  #   end
  # end
end
