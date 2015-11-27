require 'spec_helper'

describe EcolCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ecol_customers as @ecol_customers" do
      ecol_customer = Factory(:ecol_customer, :approval_status => 'A')
      get :index
      assigns(:ecol_customers).should eq([ecol_customer])
    end

    it "assigns all unapproved ecol_customers as @ecol_customers when approval_status is passed" do
      ecol_customer = Factory(:ecol_customer, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:ecol_customers).should eq([ecol_customer])
    end
  end

  describe "GET show" do
    it "assigns the requested ecol_customer as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer)
      get :show, {:id => ecol_customer.id}
      assigns(:ecol_customer).should eq(ecol_customer)
    end
  end

  describe "GET new" do
    it "assigns a new ecol_customer as @ecol_customer" do
      get :new
      assigns(:ecol_customer).should be_a_new(EcolCustomer)
    end
  end

  describe "GET edit" do
    it "assigns the requested ecol_customer with status 'U' as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer, :approval_status => 'U')
      get :edit, {:id => ecol_customer.id}
      assigns(:ecol_customer).should eq(ecol_customer)
    end

    it "assigns the requested ecol_customer with status 'A' as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer,:approval_status => 'A')
      get :edit, {:id => ecol_customer.id}
      assigns(:ecol_customer).should eq(ecol_customer)
    end

    it "assigns the new ecol_customer with requested ecol_customer params when status 'A' as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer,:approval_status => 'A')
      params = (ecol_customer.attributes).merge({:approved_id => ecol_customer.id,:approved_version => ecol_customer.lock_version})
      get :edit, {:id => ecol_customer.id}
      assigns(:ecol_customer).should eq(EcolCustomer.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ecol_customer" do
        params = Factory.attributes_for(:ecol_customer)
        expect {
          post :create, {:ecol_customer => params}
        }.to change(EcolCustomer.unscoped, :count).by(1)
        flash[:alert].should  match(/Customer successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created ecol_customer as @ecol_customer" do
        params = Factory.attributes_for(:ecol_customer)
        post :create, {:ecol_customer => params}
        assigns(:ecol_customer).should be_a(EcolCustomer)
        assigns(:ecol_customer).should be_persisted
      end

      it "redirects to the created ecol_customer" do
        params = Factory.attributes_for(:ecol_customer)
        post :create, {:ecol_customer => params}
        response.should redirect_to(EcolCustomer.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ecol_customer as @ecol_customer" do
        params = Factory.attributes_for(:ecol_customer)
        params[:code] = nil
        expect {
          post :create, {:ecol_customer => params}
        }.to change(EcolCustomer, :count).by(0)
        assigns(:ecol_customer).should be_a(EcolCustomer)
        assigns(:ecol_customer).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ecol_customer)
        params[:code] = nil
        post :create, {:ecol_customer => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ecol_customer" do
        ecol_customer = Factory(:ecol_customer, :code => "CUST01")
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = "CUST02"
        put :update, {:id => ecol_customer.id, :ecol_customer => params}
        ecol_customer.reload
        ecol_customer.code.should == "CUST02"
      end

      it "assigns the requested ecol_customer as @ecol_customer" do
        ecol_customer = Factory(:ecol_customer, :code => "CUST01")
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = "CUST02"
        put :update, {:id => ecol_customer.to_param, :ecol_customer => params}
        assigns(:ecol_customer).should eq(ecol_customer)
      end

      it "redirects to the ecol_customer" do
        ecol_customer = Factory(:ecol_customer, :code => "CUST01")
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = "CUST02"
        put :update, {:id => ecol_customer.to_param, :ecol_customer => params}
        response.should redirect_to(ecol_customer)
      end

      it "should raise error when tried to update at same time by many" do
        ecol_customer = Factory(:ecol_customer, :code => "CUST01")
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = "CUST02"
        ecol_customer2 = ecol_customer
        put :update, {:id => ecol_customer.id, :ecol_customer => params}
        ecol_customer.reload
        ecol_customer.code.should == "CUST02"
        params[:code] = "CUST03"
        put :update, {:id => ecol_customer2.id, :ecol_customer => params}
        ecol_customer.reload
        ecol_customer.code.should == "CUST02"
        flash[:alert].should  match(/Someone edited the customer the same time you did. Please re-apply your changes to the customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the ecol_customer as @ecol_customer" do
        ecol_customer = Factory(:ecol_customer, :code => "CUST01")
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = nil
        put :update, {:id => ecol_customer.to_param, :ecol_customer => params}
        assigns(:ecol_customer).should eq(ecol_customer)
        ecol_customer.reload
        params[:code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ecol_customer = Factory(:ecol_customer)
        params = ecol_customer.attributes.slice(*ecol_customer.class.attribute_names)
        params[:code] = nil
        put :update, {:id => ecol_customer.id, :ecol_customer => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested ecol_customer as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer)
      get :audit_logs, {:id => ecol_customer.id, :version_id => 0}
      assigns(:ecol_customer).should eq(ecol_customer)
      assigns(:audit).should eq(ecol_customer.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:ecol_customer).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ecol_customer1 = Factory(:ecol_customer, :code => "CUST01", :approval_status => 'A')
      ecol_customer2 = Factory(:ecol_customer, :code => "CUST01", :approval_status => 'U', :name => 'Foobar', :approved_version => ecol_customer1.lock_version, :approved_id => ecol_customer1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ecol_customer1.approval_status.should == 'A'
      EcolUnapprovedRecord.count.should == 1
      put :approve, {:id => ecol_customer2.id}
      EcolUnapprovedRecord.count.should == 0
      ecol_customer1.reload
      ecol_customer1.name.should == 'Foobar'
      ecol_customer1.updated_by.should == "666"
      EcolCustomer.find_by_id(ecol_customer2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ecol_customer = Factory(:ecol_customer, :code => "CUST01", :approval_status => 'U', :name => 'Foobar')
      put :approve, {:id => ecol_customer.id}
      ecol_customer.reload
      ecol_customer.name.should == 'Foobar'
      ecol_customer.approval_status.should == 'A'
    end

  end
end
