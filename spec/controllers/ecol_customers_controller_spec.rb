require 'spec_helper'

describe EcolCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user, :group_id => Factory(:group, :name => 'e-collect').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ecol_customers as @ecol_customers" do
      ecol_customer = Factory(:ecol_customer)
      get :index
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
    it "assigns the requested ecol_customer as @ecol_customer" do
      ecol_customer = Factory(:ecol_customer)
      get :edit, {:id => ecol_customer.id}
      assigns(:ecol_customer).should eq(ecol_customer)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ecol_customer" do
        params = Factory.attributes_for(:ecol_customer)
        expect {
          post :create, {:ecol_customer => params}
        }.to change(EcolCustomer, :count).by(1)
        flash[:alert].should  match(/Customer successfuly created/)
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
        response.should redirect_to(EcolCustomer.last)
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
end
