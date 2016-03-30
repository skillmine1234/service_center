require 'spec_helper'

describe SuCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all su_customers as @su_customers" do
      su_customer = Factory(:su_customer, :approval_status => 'A')
      get :index
      assigns(:su_customers).should eq([su_customer])
    end

    it "assigns all unapproved su_customers as @su_customers when approval_status is passed" do
      su_customer = Factory(:su_customer, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:su_customers).should eq([su_customer])
    end
  end

  describe "GET show" do
    it "assigns the requested su_customer as @su_customer" do
      su_customer = Factory(:su_customer)
      get :show, {:id => su_customer.id}
      assigns(:su_customer).should eq(su_customer)
    end
  end

  describe "GET new" do
    it "assigns a new su_customer as @su_customer" do
      get :new
      assigns(:su_customer).should be_a_new(SuCustomer)
    end
  end

  describe "GET edit" do
    it "assigns the requested su_customer with status 'U' as @su_customer" do
      su_customer = Factory(:su_customer, :approval_status => 'U')
      get :edit, {:id => su_customer.id}
      assigns(:su_customer).should eq(su_customer)
    end

    it "assigns the requested su_customer with status 'A' as @su_customer" do
      su_customer = Factory(:su_customer,:approval_status => 'A')
      get :edit, {:id => su_customer.id}
      assigns(:su_customer).should eq(su_customer)
    end

    it "assigns the new su_customer with requested su_customer params when status 'A' as @su_customer" do
      su_customer = Factory(:su_customer,:approval_status => 'A')
      params = (su_customer.attributes).merge({:approved_id => su_customer.id,:approved_version => su_customer.lock_version})
      get :edit, {:id => su_customer.id}
      assigns(:su_customer).should eq(SuCustomer.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new su_customer" do
        params = Factory.attributes_for(:su_customer)
        expect {
          post :create, {:su_customer => params}
        }.to change(SuCustomer.unscoped, :count).by(1)
        flash[:alert].should  match(/Salary Upload Customer successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created su_customer as @su_customer" do
        params = Factory.attributes_for(:su_customer)
        post :create, {:su_customer => params}
        assigns(:su_customer).should be_a(SuCustomer)
        assigns(:su_customer).should be_persisted
      end

      it "redirects to the created su_customer" do
        params = Factory.attributes_for(:su_customer)
        post :create, {:su_customer => params}
        response.should redirect_to(SuCustomer.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved su_customer as @su_customer" do
        params = Factory.attributes_for(:su_customer)
        params[:account_no] = nil
        expect {
          post :create, {:su_customer => params}
        }.to change(SuCustomer, :count).by(0)
        assigns(:su_customer).should be_a(SuCustomer)
        assigns(:su_customer).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:su_customer)
        params[:account_no] = nil
        post :create, {:su_customer => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested su_customer" do
        su_customer = Factory(:su_customer, :account_no => "1234567893")
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = "1234567894"
        put :update, {:id => su_customer.id, :su_customer => params}
        su_customer.reload
        su_customer.account_no.should == "1234567894"
      end

      it "assigns the requested su_customer as @su_customer" do
        su_customer = Factory(:su_customer, :account_no => "1234567893")
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = "1234567894"
        put :update, {:id => su_customer.to_param, :su_customer => params}
        assigns(:su_customer).should eq(su_customer)
      end

      it "redirects to the su_customer" do
        su_customer = Factory(:su_customer, :account_no => "1234567893")
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = "1234567894"
        put :update, {:id => su_customer.to_param, :su_customer => params}
        response.should redirect_to(su_customer)
      end

      it "should raise error when tried to update at same time by many" do
        su_customer = Factory(:su_customer, :account_no => "1234567893")
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = "1234567894"
        su_customer2 = su_customer
        put :update, {:id => su_customer.id, :su_customer => params}
        su_customer.reload
        su_customer.account_no.should == "1234567894"
        params[:account_no] = "1234567895"
        put :update, {:id => su_customer2.id, :su_customer => params}
        su_customer.reload
        su_customer.account_no.should == "1234567894"
        flash[:alert].should  match(/Someone edited the Salary Upload Customer the same time you did. Please re-apply your changes to the Salary Upload Customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the su_customer as @su_customer" do
        su_customer = Factory(:su_customer, :account_no => "1234567893")
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = nil
        put :update, {:id => su_customer.to_param, :su_customer => params}
        assigns(:su_customer).should eq(su_customer)
        su_customer.reload
        params[:account_no] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        su_customer = Factory(:su_customer)
        params = su_customer.attributes.slice(*su_customer.class.attribute_names)
        params[:account_no] = nil
        put :update, {:id => su_customer.id, :su_customer => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested su_customer as @su_customer" do
      su_customer = Factory(:su_customer)
      get :audit_logs, {:id => su_customer.id, :version_id => 0}
      assigns(:su_customer).should eq(su_customer)
      assigns(:audit).should eq(su_customer.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:su_customer).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      su_customer1 = Factory(:su_customer, :approval_status => 'A')
      su_customer2 = Factory(:su_customer, :approval_status => 'U', :account_no => '1234567896', :approved_version => su_customer1.lock_version, :approved_id => su_customer1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      su_customer1.approval_status.should == 'A'
      SuUnapprovedRecord.count.should == 1
      put :approve, {:id => su_customer2.id}
      SuUnapprovedRecord.count.should == 0
      su_customer1.reload
      su_customer1.account_no.should == '1234567896'
      su_customer1.updated_by.should == "666"
      SuUnapprovedRecord.find_by_id(su_customer2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      su_customer = Factory(:su_customer, :account_no => '1234567898', :approval_status => 'U')
      SuUnapprovedRecord.count.should == 1
      put :approve, {:id => su_customer.id}
      SuUnapprovedRecord.count.should == 0
      su_customer.reload
      su_customer.account_no.should == '1234567898'
      su_customer.approval_status.should == 'A'
    end
  end
end
