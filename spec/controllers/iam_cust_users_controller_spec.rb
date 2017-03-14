require 'spec_helper'
require 'flexmock/test_unit'

describe IamCustUsersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
    
    mock_ldap
  end

  describe "GET index" do
    it "assigns all iam_cust_users as @iam_cust_users" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'A')
      get :index
      assigns(:iam_cust_users).should eq([iam_cust_user])
    end

    it "assigns all unapproved iam_cust_users as @iam_cust_users when approval_status is passed" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:iam_cust_users).should eq([iam_cust_user])
    end
  end

  describe "GET show" do
    it "assigns the requested iam_cust_user as @iam_cust_user" do
      iam_cust_user = Factory(:iam_cust_user)
      get :show, {:id => iam_cust_user.id}
      assigns(:iam_cust_user).should eq(iam_cust_user)
    end
  end

  describe "GET new" do
    it "assigns a new iam_cust_user as @iam_cust_user" do
      get :new
      assigns(:iam_cust_user).should be_a_new(IamCustUser)
    end
  end

  describe "GET edit" do
    it "assigns the requested iam_cust_user with status 'U' as @iam_cust_user" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'U')
      get :edit, {:id => iam_cust_user.id}
      assigns(:iam_cust_user).should eq(iam_cust_user)
    end

    it "assigns the requested iam_cust_user with status 'A' as @iam_cust_user" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'A')
      get :edit, {:id => iam_cust_user.id}
      assigns(:iam_cust_user).should eq(iam_cust_user)
    end

    it "assigns the new iam_cust_user with requested iam_cust_user params when status 'A' as @iam_cust_user" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'A')
      params = (iam_cust_user.attributes).merge({:approved_id => iam_cust_user.id, :approved_version => iam_cust_user.lock_version})
      get :edit, {:id => iam_cust_user.id}
      assigns(:iam_cust_user).should eq(IamCustUser.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new iam_cust_user" do
        params = Factory.attributes_for(:iam_cust_user)
        expect {
          post :create, {:iam_cust_user => params}
        }.to change(IamCustUser.unscoped, :count).by(1)
        flash[:alert].should  match(/User successfully created is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created iam_cust_user as @iam_cust_user" do
        params = Factory.attributes_for(:iam_cust_user)
        post :create, {:iam_cust_user => params}
        assigns(:iam_cust_user).should be_a(IamCustUser)
        assigns(:iam_cust_user).should be_persisted
      end

      it "redirects to the created iam_cust_user" do
        params = Factory.attributes_for(:iam_cust_user)
        post :create, {:iam_cust_user => params}
        response.should redirect_to(IamCustUser.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved iam_cust_user as @iam_cust_user" do
        params = Factory.attributes_for(:iam_cust_user)
        params[:first_name] = nil
        expect {
          post :create, {:iam_cust_user => params}
        }.to change(IamCustUser, :count).by(0)
        assigns(:iam_cust_user).should be_a(IamCustUser)
        assigns(:iam_cust_user).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:iam_cust_user)
        params[:first_name] = nil
        post :create, {:iam_cust_user => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested iam_cust_user" do
        iam_cust_user = Factory(:iam_cust_user, :first_name => "Foo")
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = "Bar"
        put :update, {:id => iam_cust_user.id, :iam_cust_user => params}
        iam_cust_user.reload
        iam_cust_user.first_name.should == "Bar"
      end

      it "assigns the requested iam_cust_user as @iam_cust_user" do
        iam_cust_user = Factory(:iam_cust_user, :first_name => "Foo")
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = "Bar"
        put :update, {:id => iam_cust_user.to_param, :iam_cust_user => params}
        assigns(:iam_cust_user).should eq(iam_cust_user)
      end

      it "redirects to the iam_cust_user" do
        iam_cust_user = Factory(:iam_cust_user, :first_name => "Foo")
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = "Bar"
        put :update, {:id => iam_cust_user.to_param, :iam_cust_user => params}
        response.should redirect_to(iam_cust_user)
      end

      it "should raise error when tried to update at same time by many" do
        iam_cust_user = Factory(:iam_cust_user, :first_name => "Foo")
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = "Bar"
        iam_cust_user2 = iam_cust_user
        put :update, {:id => iam_cust_user.id, :iam_cust_user => params}
        iam_cust_user.reload
        iam_cust_user.first_name.should == "Bar"
        params[:first_name] = "Jim"
        put :update, {:id => iam_cust_user2.id, :iam_cust_user => params}
        iam_cust_user.reload
        iam_cust_user.first_name.should == "Bar"
        flash[:alert].should  match(/Someone edited the user the same time you did. Please re-apply your changes to the user./)
      end
    end

    describe "with invalid params" do
      it "assigns the iam_cust_user as @iam_cust_user" do
        iam_cust_user = Factory(:iam_cust_user, :first_name => "Foo")
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = nil
        put :update, {:id => iam_cust_user.to_param, :iam_cust_user => params}
        assigns(:iam_cust_user).should eq(iam_cust_user)
        iam_cust_user.reload
        params[:first_name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        iam_cust_user = Factory(:iam_cust_user)
        params = iam_cust_user.attributes.slice(*iam_cust_user.class.attribute_names)
        params[:first_name] = nil
        put :update, {:id => iam_cust_user.id, :iam_cust_user => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested iam_cust_user as @iam_cust_user" do
      iam_cust_user = Factory(:iam_cust_user)
      get :audit_logs, {:id => iam_cust_user.id, :version_id => 0}
      assigns(:iam_cust_user).should eq(iam_cust_user)
      assigns(:audit).should eq(iam_cust_user.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:iam_cust_user).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      iam_cust_user1 = Factory(:iam_cust_user, :approval_status => 'A')
      iam_cust_user2 = Factory(:iam_cust_user, :approval_status => 'U', :first_name => 'Foo', :approved_version => iam_cust_user1.lock_version, :approved_id => iam_cust_user1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      iam_cust_user1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => iam_cust_user2.id}
      UnapprovedRecord.count.should == 0
      iam_cust_user1.reload
      iam_cust_user1.first_name.should == 'Foo'
      iam_cust_user1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(iam_cust_user2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      iam_cust_user = Factory(:iam_cust_user, :first_name => 'Foo', :approval_status => 'U')
      UnapprovedRecord.count.should == 1
      put :approve, {:id => iam_cust_user.id}
      UnapprovedRecord.count.should == 0
      iam_cust_user.reload
      iam_cust_user.first_name.should == 'Foo'
      iam_cust_user.approval_status.should == 'A'
    end
  end
end
