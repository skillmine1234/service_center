require 'spec_helper'
require "cancan_matcher"
# include Devise::TestHelpers

describe Admin::UserRolesController do
  render_views

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @admin_user = Factory(:admin_user, :email => "test@gmail.com", :password => "password")
    @admin_user.add_role(:admin)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all user_roles as @collection" do
      user_role = Factory(:user_role, :approval_status => 'A')
      get :index
      assigns(:collection).should eq([user_role])
    end
    it "assigns all unapproved user_roles as @user_roles when approval_status is passed" do
      @admin_user.add_role(:approver_admin)
      user_role = Factory(:user_role, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:collection).should eq([user_role])
    end
  end

  describe "GET show" do
    it "assigns the requested user_role as @user_role" do
      user_role = Factory(:user_role)
      get :show, {:id => user_role.id}
      assigns(:user_role).should eq(user_role)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_role as @user_role" do
      user_role = Factory(:user_role,:approval_status => 'U')
      get :edit, {:id => user_role.id}
      assigns(:user_role).should eq(user_role)
    end

    it "assigns the new user_role with requested user_role params when status 'A' as user_role" do
      user_role = Factory(:user_role,:approval_status => 'A')
      params = ({:user_id => user_role.user_id, :role_id => user_role.role_id}).merge({:approved_id => user_role.id,:approved_version => user_role.lock_version})
      get :edit, {:id => user_role.id}
      assigns(:user_role).id.should be_nil
      assigns(:user_role).user_id.should == user_role.user_id
      assigns(:user_role).role_id.should == user_role.role_id
      assigns(:user_role).approved_id.should == user_role.id
      assigns(:user_role).approved_version.should == user_role.lock_version
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new user_role" do
        params = Factory.attributes_for(:user_role)
        expect {
          post :create, {:user_role => params}
        }.to change(UserRole.unscoped, :count).by(1)
        flash[:alert].should  match(/User Role successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created user_role as @user_role" do
        params = Factory.attributes_for(:user_role)
        post :create, {:user_role => params}
        assigns(:user_role).should be_a(UserRole)
        assigns(:user_role).should be_persisted
      end

      it "redirects to the created user_role" do
        params = Factory.attributes_for(:user_role)
        post :create, {:user_role => params}
        response.should redirect_to(admin_user_role_path(UserRole.unscoped.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_role as @user_role" do
        params = Factory.attributes_for(:user_role)
        params[:user_id] = nil
        expect {
          post :create, {:user_role => params}
        }.to change(UserRole, :count).by(0)
        assigns(:user_role).should be_a(UserRole)
        assigns(:user_role).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:user_role)
        params[:user_id] = nil
        post :create, {:user_role => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user_role" do
        user_role = Factory(:user_role, :user_id => "abcd")
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = 3
        put :update, {:id => user_role.id, :user_role => params}
        user_role.reload
        user_role.user_id.should == 3
      end

      it "assigns the requested user_role as @user_role" do
        user_role = Factory(:user_role, :user_id => "abcd")
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = 15
        put :update, {:id => user_role.to_param, :user_role => params}
        assigns(:user_role).should eq(user_role)
      end

      it "redirects to the user_role" do
        user_role = Factory(:user_role)
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = 4
        put :update, {:id => user_role.to_param, :user_role => params}
        response.should redirect_to(admin_user_role_path(user_role))
      end

      it "should raise error when tried to update at same time by many" do
        user_role = Factory(:user_role)
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = 4
        user_role2 = user_role
        put :update, {:id => user_role.id, :user_role => params}
        user_role.reload
        user_role.user_id.should == 4
        params[:user_id] = 5
        put :update, {:id => user_role2.id, :user_role => params}
        user_role.reload
        user_role.user_id.should == 4
        flash[:alert].should  match(/Someone edited the user role the same time you did. Please re-apply your changes to the user role/)
      end
    end

    describe "with invalid params" do
      it "assigns the user_role as @user_role" do
        user_role = Factory(:user_role)
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = nil
        put :update, {:id => user_role.to_param, :user_role => params}
        assigns(:user_role).should eq(user_role)
        user_role.reload
        params[:user_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        user_role = Factory(:user_role)
        params = user_role.attributes.slice(*user_role.class.attribute_names)
        params[:user_id] = nil
        put :update, {:id => user_role.id, :user_role => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end

  describe "PUT approve" do
    it "unapproved record can be approved and old approved record will be deleted" do
      user_role1 = Factory(:user_role, :approval_status => 'A')
      user_role2 = Factory(:user_role, :approval_status => 'U', :approved_version => user_role1.lock_version, :approved_id => user_role1.id)
      put :approve, {:id => user_role2.id}
      user_role2.reload
      user_role2.approval_status.should == 'A'
      UserRole.find_by_id(user_role1.id).should be_nil
    end
  end
end