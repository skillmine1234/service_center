require 'spec_helper'
require 'flexmock/test_unit'

describe IamOrganisationsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
    
    mock_ldap
  end

  describe "GET index" do
    it "assigns all iam_organisations as @records" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      get :index
      assigns(:records).should eq([iam_organisation])
    end

    it "assigns all unapproved iam_organisations as @records when approval_status is passed" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:records).should eq([iam_organisation])
    end
  end

  describe "GET show" do
    it "assigns the requested iam_organisation as @iam_organisation" do
      iam_organisation = Factory(:iam_organisation)
      get :show, {:id => iam_organisation.id}
      assigns(:iam_organisation).should eq(iam_organisation)
    end
  end

  describe "GET new" do
    it "assigns a new iam_organisation as @iam_organisation" do
      get :new
      assigns(:iam_organisation).should be_a_new(IamOrganisation)
    end
  end

  describe "GET edit" do
    it "assigns the requested iam_organisation with status 'U' as @iam_organisation" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'U')
      get :edit, {:id => iam_organisation.id}
      assigns(:iam_organisation).should eq(iam_organisation)
    end

    it "assigns the requested iam_organisation with status 'A' as @iam_organisation" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      get :edit, {:id => iam_organisation.id}
      assigns(:iam_organisation).should eq(iam_organisation)
    end

    it "assigns the new iam_organisation with requested iam_organisation params when status 'A' as @iam_organisation" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      params = (iam_organisation.attributes).merge({:approved_id => iam_organisation.id, :approved_version => iam_organisation.lock_version})
      get :edit, {:id => iam_organisation.id}
      assigns(:iam_organisation).should eq(IamOrganisation.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new iam_organisation" do
        params = Factory.attributes_for(:iam_organisation)
        expect {
          post :create, {:iam_organisation => params}
        }.to change(IamOrganisation.unscoped, :count).by(1)
        flash[:alert].should  match(/Organisation successfully created is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created iam_organisation as @iam_organisation" do
        params = Factory.attributes_for(:iam_organisation)
        post :create, {:iam_organisation => params}
        assigns(:iam_organisation).should be_a(IamOrganisation)
        assigns(:iam_organisation).should be_persisted
      end

      it "redirects to the created iam_organisation" do
        params = Factory.attributes_for(:iam_organisation)
        post :create, {:iam_organisation => params}
        response.should redirect_to(IamOrganisation.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved iam_organisation as @iam_organisation" do
        params = Factory.attributes_for(:iam_organisation)
        params[:name] = nil
        expect {
          post :create, {:iam_organisation => params}
        }.to change(IamOrganisation, :count).by(0)
        assigns(:iam_organisation).should be_a(IamOrganisation)
        assigns(:iam_organisation).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:iam_organisation)
        params[:name] = nil
        post :create, {:iam_organisation => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested iam_organisation" do
        iam_organisation = Factory(:iam_organisation, :name => "Foo")
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = "Bar"
        put :update, {:id => iam_organisation.id, :iam_organisation => params}
        iam_organisation.reload
        iam_organisation.name.should == "Bar"
      end

      it "assigns the requested iam_organisation as @iam_organisation" do
        iam_organisation = Factory(:iam_organisation, :name => "Foo")
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = "Bar"
        put :update, {:id => iam_organisation.to_param, :iam_organisation => params}
        assigns(:iam_organisation).should eq(iam_organisation)
      end

      it "redirects to the iam_organisation" do
        iam_organisation = Factory(:iam_organisation, :name => "Foo")
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = "Bar"
        put :update, {:id => iam_organisation.to_param, :iam_organisation => params}
        response.should redirect_to(iam_organisation)
      end

      it "should raise error when tried to update at same time by many" do
        iam_organisation = Factory(:iam_organisation, :name => "Foo")
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = "Bar"
        iam_organisation2 = iam_organisation
        put :update, {:id => iam_organisation.id, :iam_organisation => params}
        iam_organisation.reload
        iam_organisation.name.should == "Bar"
        params[:name] = "Jim"
        put :update, {:id => iam_organisation2.id, :iam_organisation => params}
        iam_organisation.reload
        iam_organisation.name.should == "Bar"
        flash[:alert].should  match(/Someone edited the organisation the same time you did. Please re-apply your changes to the organisation./)
      end
    end

    describe "with invalid params" do
      it "assigns the iam_organisation as @iam_organisation" do
        iam_organisation = Factory(:iam_organisation, :name => "Foo")
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = nil
        put :update, {:id => iam_organisation.to_param, :iam_organisation => params}
        assigns(:iam_organisation).should eq(iam_organisation)
        iam_organisation.reload
        params[:name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        iam_organisation = Factory(:iam_organisation)
        params = iam_organisation.attributes.slice(*iam_organisation.class.attribute_names)
        params[:name] = nil
        put :update, {:id => iam_organisation.id, :iam_organisation => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested iam_organisation as @iam_organisation" do
      iam_organisation = Factory(:iam_organisation)
      get :audit_logs, {:id => iam_organisation.id, :version_id => 0}
      assigns(:iam_organisation).should eq(iam_organisation)
      assigns(:audit).should eq(iam_organisation.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:iam_organisation).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      iam_organisation1 = Factory(:iam_organisation, :approval_status => 'A')
      iam_organisation2 = Factory(:iam_organisation, :approval_status => 'U', :name => 'Foo', :approved_version => iam_organisation1.lock_version, :approved_id => iam_organisation1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      iam_organisation1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => iam_organisation2.id}
      UnapprovedRecord.count.should == 0
      iam_organisation1.reload
      iam_organisation1.name.should == 'Foo'
      iam_organisation1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(iam_organisation2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      iam_organisation = Factory(:iam_organisation, :name => 'Foo', :approval_status => 'U')
      UnapprovedRecord.count.should == 1
      put :approve, {:id => iam_organisation.id}
      UnapprovedRecord.count.should == 0
      iam_organisation.reload
      iam_organisation.name.should == 'Foo'
      iam_organisation.approval_status.should == 'A'
    end
  end
end
