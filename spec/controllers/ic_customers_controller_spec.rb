require 'spec_helper'

describe IcCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ic_customers as @ic_customers" do
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      get :index
      assigns(:ic_customers).should eq([ic_customer])
    end

    it "assigns all unapproved ic_customers as @ic_customers when approval_status is passed" do
      ic_customer = Factory(:ic_customer, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:ic_customers).should eq([ic_customer])
    end
  end

  describe "GET show" do
    it "assigns the requested ic_customer as @ic_customer" do
      ic_customer = Factory(:ic_customer)
      get :show, {:id => ic_customer.id}
      assigns(:ic_customer).should eq(ic_customer)
    end
  end

  describe "GET new" do
    it "assigns a new ic_customer as @ic_customer" do
      get :new
      assigns(:ic_customer).should be_a_new(IcCustomer)
    end
  end

  describe "GET edit" do
    it "assigns the requested ic_customer with status 'U' as @ic_customer" do
      ic_customer = Factory(:ic_customer, :approval_status => 'U')
      get :edit, {:id => ic_customer.id}
      assigns(:ic_customer).should eq(ic_customer)
    end

    it "assigns the requested ic_customer with status 'A' as @ic_customer" do
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      get :edit, {:id => ic_customer.id}
      assigns(:ic_customer).should eq(ic_customer)
    end

    it "assigns the new ic_customer with requested ic_customer params when status 'A' as @ic_customer" do
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      params = (ic_customer.attributes).merge({:approved_id => ic_customer.id, :approved_version => ic_customer.lock_version})
      get :edit, {:id => ic_customer.id}
      assigns(:ic_customer).should eq(IcCustomer.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ic_customer" do
        params = Factory.attributes_for(:ic_customer)
        expect {
          post :create, {:ic_customer => params}
        }.to change(IcCustomer.unscoped, :count).by(1)
        flash[:alert].should  match(/Instant Credit Customer successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created ic_customer as @ic_customer" do
        params = Factory.attributes_for(:ic_customer)
        post :create, {:ic_customer => params}
        assigns(:ic_customer).should be_a(IcCustomer)
        assigns(:ic_customer).should be_persisted
      end

      it "redirects to the created ic_customer" do
        params = Factory.attributes_for(:ic_customer)
        post :create, {:ic_customer => params}
        response.should redirect_to(IcCustomer.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ic_customer as @ic_customer" do
        params = Factory.attributes_for(:ic_customer)
        params[:customer_id] = nil
        expect {
          post :create, {:ic_customer => params}
        }.to change(IcCustomer, :count).by(0)
        assigns(:ic_customer).should be_a(IcCustomer)
        assigns(:ic_customer).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ic_customer)
        params[:customer_id] = nil
        post :create, {:ic_customer => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ic_customer" do
        ic_customer = Factory(:ic_customer, :customer_id => "112233")
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_customer.id, :ic_customer => params}
        ic_customer.reload
        ic_customer.customer_id.should == "112234"
      end

      it "assigns the requested ic_customer as @ic_customer" do
        ic_customer = Factory(:ic_customer, :customer_id => "112233")
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_customer.to_param, :ic_customer => params}
        assigns(:ic_customer).should eq(ic_customer)
      end

      it "redirects to the ic_customer" do
        ic_customer = Factory(:ic_customer, :customer_id => "112233")
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_customer.to_param, :ic_customer => params}
        response.should redirect_to(ic_customer)
      end

      it "should raise error when tried to update at same time by many" do
        ic_customer = Factory(:ic_customer, :customer_id => "112233")
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = "112234"
        ic_customer2 = ic_customer
        put :update, {:id => ic_customer.id, :ic_customer => params}
        ic_customer.reload
        ic_customer.customer_id.should == "112234"
        params[:customer_id] = "112235"
        put :update, {:id => ic_customer2.id, :ic_customer => params}
        ic_customer.reload
        ic_customer.customer_id.should == "112234"
        flash[:alert].should  match(/Someone edited the Instant Credit Customer the same time you did. Please re-apply your changes to the Instant Credit Customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the ic_customer as @ic_customer" do
        ic_customer = Factory(:ic_customer, :customer_id => "112233")
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = nil
        put :update, {:id => ic_customer.to_param, :ic_customer => params}
        assigns(:ic_customer).should eq(ic_customer)
        ic_customer.reload
        params[:customer_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ic_customer = Factory(:ic_customer)
        params = ic_customer.attributes.slice(*ic_customer.class.attribute_names)
        params[:customer_id] = nil
        put :update, {:id => ic_customer.id, :ic_customer => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested ic_customer as @ic_customer" do
      ic_customer = Factory(:ic_customer)
      get :audit_logs, {:id => ic_customer.id, :version_id => 0}
      assigns(:ic_customer).should eq(ic_customer)
      assigns(:audit).should eq(ic_customer.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:ic_customer).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ic_customer1 = Factory(:ic_customer, :approval_status => 'A')
      ic_customer2 = Factory(:ic_customer, :approval_status => 'U', :customer_id => '112233', :approved_version => ic_customer1.lock_version, :approved_id => ic_customer1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ic_customer1.approval_status.should == 'A'
      IcUnapprovedRecord.count.should == 1
      put :approve, {:id => ic_customer2.id}
      IcUnapprovedRecord.count.should == 0
      ic_customer1.reload
      ic_customer1.customer_id.should == '112233'
      ic_customer1.updated_by.should == "666"
      IcUnapprovedRecord.find_by_id(ic_customer2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ic_customer = Factory(:ic_customer, :customer_id => '112233', :approval_status => 'U')
      IcUnapprovedRecord.count.should == 1
      put :approve, {:id => ic_customer.id}
      IcUnapprovedRecord.count.should == 0
      ic_customer.reload
      ic_customer.customer_id.should == '112233'
      ic_customer.approval_status.should == 'A'
    end
  end
end
