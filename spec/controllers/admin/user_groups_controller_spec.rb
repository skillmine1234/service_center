require 'spec_helper'
require "cancan_matcher"
# include Devise::TestHelpers

describe Admin::UserGroupsController do
  render_views

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @admin_user = Factory(:admin_user, :email => "test@gmail.com", :password => "password")
    @admin_user.add_role(:admin)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all user_groups as @collection" do
      user_group = Factory(:user_group, :user_id => 2, :approval_status => 'A')
      get :index
      assigns(:collection).should eq([user_group])
    end
    it "assigns all unapproved user_groups as @user_groups when approval_status is passed" do
      @admin_user.add_role(:approver_admin)
      user_group = Factory(:user_group, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:collection).should eq([user_group])
    end
  end

  describe "GET show" do
    it "assigns the requested user_group as @user_group" do
      user_group = Factory(:user_group)
      get :show, {:id => user_group.id}
      assigns(:user_group).should eq(user_group)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_group as @user_group" do
      user_group = Factory(:user_group,:approval_status => 'U')
      get :edit, {:id => user_group.id}
      assigns(:user_group).should eq(user_group)
    end

    it "assigns the new user_group with requested user_group params when status 'A' as user_group" do
      user_group = Factory(:user_group,:approval_status => 'A')
      params = ({:user_id => user_group.user_id, :group_id => user_group.group_id}).merge({:approved_id => user_group.id,:approved_version => user_group.lock_version})
      get :edit, {:id => user_group.id}
      assigns(:user_group).id.should be_nil
      assigns(:user_group).user_id.should == user_group.user_id
      assigns(:user_group).group_id.should == user_group.group_id
      assigns(:user_group).approved_id.should == user_group.id
      assigns(:user_group).approved_version.should == user_group.lock_version
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new user_group" do
        params = Factory.attributes_for(:user_group)
        expect {
          post :create, {:user_group => params}
        }.to change(UserGroup.unscoped, :count).by(1)
        flash[:alert].should  match(/User group successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created user_group as @user_group" do
        params = Factory.attributes_for(:user_group)
        post :create, {:user_group => params}
        assigns(:user_group).should be_a(UserGroup)
        assigns(:user_group).should be_persisted
      end

      it "redirects to the created user_group" do
        params = Factory.attributes_for(:user_group)
        post :create, {:user_group => params}
        response.should redirect_to(admin_user_group_path(UserGroup.unscoped.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_group as @user_group" do
        params = Factory.attributes_for(:user_group)
        params[:user_id] = nil
        expect {
          post :create, {:user_group => params}
        }.to change(UserGroup, :count).by(0)
        assigns(:user_group).should be_a(UserGroup)
        assigns(:user_group).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:user_group)
        params[:user_id] = nil
        post :create, {:user_group => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user_group" do
        user_group = Factory(:user_group, :user_id => "abcd")
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = 3
        put :update, {:id => user_group.id, :user_group => params}
        user_group.reload
        user_group.user_id.should == 3
      end

      it "assigns the requested user_group as @user_group" do
        user_group = Factory(:user_group, :user_id => "abcd")
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = 15
        put :update, {:id => user_group.to_param, :user_group => params}
        assigns(:user_group).should eq(user_group)
      end

      it "redirects to the user_group" do
        user_group = Factory(:user_group)
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = 4
        put :update, {:id => user_group.to_param, :user_group => params}
        response.should redirect_to(admin_user_group_path(user_group))
      end

      it "should raise error when tried to update at same time by many" do
        user_group = Factory(:user_group)
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = 4
        user_group2 = user_group
        put :update, {:id => user_group.id, :user_group => params}
        user_group.reload
        user_group.user_id.should == 4
        params[:user_id] = 5
        put :update, {:id => user_group2.id, :user_group => params}
        user_group.reload
        user_group.user_id.should == 4
        flash[:alert].should  match(/Someone edited the user group the same time you did. Please re-apply your changes to the user group/)
      end
    end

    describe "with invalid params" do
      it "assigns the user_group as @user_group" do
        user_group = Factory(:user_group)
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = nil
        put :update, {:id => user_group.to_param, :user_group => params}
        assigns(:user_group).should eq(user_group)
        user_group.reload
        params[:user_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        user_group = Factory(:user_group)
        params = user_group.attributes.slice(*user_group.class.attribute_names)
        params[:user_id] = nil
        put :update, {:id => user_group.id, :user_group => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end

  describe "PUT approve" do
    it "unapproved record can be approved and old approved record will be deleted" do
      user_group1 = Factory(:user_group, :approval_status => 'A')
      user_group2 = Factory(:user_group, :approval_status => 'U', :approved_version => user_group1.lock_version, :approved_id => user_group1.id)
      put :approve, {:id => user_group2.id}
      user_group1.reload
      user_group1.approval_status.should == 'A'
      UserGroup.find_by_id(user_group2.id).should be_nil
    end
  end
end