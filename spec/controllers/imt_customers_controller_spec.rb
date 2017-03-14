require 'spec_helper'

describe ImtCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
    
    mock_ldap
  end

  describe "GET index" do
    it "assigns all imt_customers as @imt_customers" do
      imt_customer = Factory(:imt_customer, :approval_status => 'A')
      get :index
      assigns(:imt_customers).should eq([imt_customer])
    end

    it "assigns all unapproved imt_customers as @imt_customers when approval_status is passed" do
      imt_customer = Factory(:imt_customer, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:imt_customers).should eq([imt_customer])
    end
  end

  describe "GET show" do
    it "assigns the requested imt_customer as @imt_customer" do
      imt_customer = Factory(:imt_customer)
      get :show, {:id => imt_customer.id}
      assigns(:imt_customer).should eq(imt_customer)
    end
  end

  describe "GET new" do
    it "assigns a new imt_customer as @imt_customer" do
      get :new
      assigns(:imt_customer).should be_a_new(ImtCustomer)
    end
  end

  describe "GET edit" do
    it "assigns the requested imt_customer with status 'U' as @imt_customer" do
      imt_customer = Factory(:imt_customer, :approval_status => 'U')
      get :edit, {:id => imt_customer.id}
      assigns(:imt_customer).should eq(imt_customer)
    end

    it "assigns the requested imt_customer with status 'A' as @imt_customer" do
      imt_customer = Factory(:imt_customer,:approval_status => 'A')
      get :edit, {:id => imt_customer.id}
      assigns(:imt_customer).should eq(imt_customer)
    end

    it "assigns the new imt_customer with requested imt_customer params when status 'A' as @imt_customer" do
      imt_customer = Factory(:imt_customer,:approval_status => 'A')
      params = (imt_customer.attributes).merge({:approved_id => imt_customer.id,:approved_version => imt_customer.lock_version})
      get :edit, {:id => imt_customer.id}
      assigns(:imt_customer).should eq(ImtCustomer.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new imt_customer" do
        params = Factory.attributes_for(:imt_customer)
        expect {
          post :create, {:imt_customer => params}
        }.to change(ImtCustomer.unscoped, :count).by(1)
        flash[:alert].should  match(/Customer successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created imt_customer as @imt_customer" do
        params = Factory.attributes_for(:imt_customer)
        post :create, {:imt_customer => params}
        assigns(:imt_customer).should be_a(ImtCustomer)
        assigns(:imt_customer).should be_persisted
      end

      it "redirects to the created imt_customer" do
        params = Factory.attributes_for(:imt_customer)
        post :create, {:imt_customer => params}
        response.should redirect_to(ImtCustomer.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved imt_customer as @imt_customer" do
        params = Factory.attributes_for(:imt_customer)
        params[:customer_name] = nil
        expect {
          post :create, {:imt_customer => params}
        }.to change(ImtCustomer, :count).by(0)
        assigns(:imt_customer).should be_a(ImtCustomer)
        assigns(:imt_customer).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:imt_customer)
        params[:customer_name] = nil
        post :create, {:imt_customer => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested imt_customer" do
        imt_customer = Factory(:imt_customer, :customer_name => "CUST01")
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = "CUST02"
        put :update, {:id => imt_customer.id, :imt_customer => params}
        imt_customer.reload
        imt_customer.customer_name.should == "CUST02"
      end

      it "assigns the requested imt_customer as @imt_customer" do
        imt_customer = Factory(:imt_customer, :customer_name => "CUST01")
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = "CUST02"
        put :update, {:id => imt_customer.to_param, :imt_customer => params}
        assigns(:imt_customer).should eq(imt_customer)
      end

      it "redirects to the imt_customer" do
        imt_customer = Factory(:imt_customer, :customer_name => "CUST01")
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = "CUST02"
        put :update, {:id => imt_customer.to_param, :imt_customer => params}
        response.should redirect_to(imt_customer)
      end

      it "should raise error when tried to update at same time by many" do
        imt_customer = Factory(:imt_customer, :customer_name => "CUST01")
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = "CUST02"
        imt_customer2 = imt_customer
        put :update, {:id => imt_customer.id, :imt_customer => params}
        imt_customer.reload
        imt_customer.customer_name.should == "CUST02"
        params[:customer_name] = "CUST03"
        put :update, {:id => imt_customer2.id, :imt_customer => params}
        imt_customer.reload
        imt_customer.customer_name.should == "CUST02"
        flash[:alert].should  match(/Someone edited the Customer the same time you did. Please re-apply your changes to the Customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the imt_customer as @imt_customer" do
        imt_customer = Factory(:imt_customer, :customer_name => "CUST01")
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = nil
        put :update, {:id => imt_customer.to_param, :imt_customer => params}
        assigns(:imt_customer).should eq(imt_customer)
        imt_customer.reload
        params[:customer_name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        imt_customer = Factory(:imt_customer)
        params = imt_customer.attributes.slice(*imt_customer.class.attribute_names)
        params[:customer_name] = nil
        put :update, {:id => imt_customer.id, :imt_customer => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested imt_customer as @imt_customer" do
      imt_customer = Factory(:imt_customer)
      get :audit_logs, {:id => imt_customer.id, :version_id => 0}
      assigns(:imt_customer).should eq(imt_customer)
      assigns(:audit).should eq(imt_customer.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:imt_customer).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      imt_customer1 = Factory(:imt_customer, :approval_status => 'A')
      imt_customer2 = Factory(:imt_customer, :approval_status => 'U', :customer_name => 'Bar Foo', :approved_version => imt_customer1.lock_version, :approved_id => imt_customer1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      imt_customer1.approval_status.should == 'A'
      ImtUnapprovedRecord.count.should == 1
      put :approve, {:id => imt_customer2.id}
      ImtUnapprovedRecord.count.should == 0
      imt_customer1.reload
      imt_customer1.customer_name.should == 'BAR FOO'
      imt_customer1.updated_by.should == "666"
      ImtCustomer.find_by_id(imt_customer2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      imt_customer = Factory(:imt_customer, :customer_name => 'Bar Foo', :approval_status => 'U')
      ImtUnapprovedRecord.count.should == 1
      put :approve, {:id => imt_customer.id}
      ImtUnapprovedRecord.count.should == 0
      imt_customer.reload
      imt_customer.customer_name.should == 'BAR FOO'
      imt_customer.approval_status.should == 'A'
    end
  end
end
