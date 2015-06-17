require 'spec_helper'

describe EcolRemittersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all ecol_remitters as @ecol_remitters" do
      ecol_customer = Factory(:ecol_customer)
      ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer)
      get :index
      assigns(:ecol_remitters).should eq([ecol_remitter])
    end
  end
  
  describe "GET show" do
    it "assigns the requested ecol_remitter as @ecol_remitter" do
      ecol_customer = Factory(:ecol_customer)
      ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer)
      get :show, {:id => ecol_remitter.id}
      assigns(:ecol_remitter).should eq(ecol_remitter)
    end
  end

  describe "GET new" do
    it "assigns a new ecol_remitter as @ecol_remitter" do
      get :new
      assigns(:ecol_remitter).should be_a_new(EcolRemitter)
    end
  end

  describe "GET edit" do
    it "assigns the requested ecol_remitter as @ecol_remitter" do
      ecol_customer = Factory(:ecol_customer)
      ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer)
      get :edit, {:id => ecol_remitter.id}
      assigns(:ecol_remitter).should eq(ecol_remitter)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        params = Factory.attributes_for(:ecol_remitter, :ecol_customer => ecol_customer)
        expect {
          post :create, {:ecol_remitter => params}
        }.to change(EcolRemitter, :count).by(1)
        flash[:alert].should  match(/Remitter successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created ecol_remitter as @ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        params = Factory.attributes_for(:ecol_remitter, :ecol_customer => ecol_customer)
        post :create, {:ecol_remitter => params}
        assigns(:ecol_remitter).should be_a(EcolRemitter)
        assigns(:ecol_remitter).should be_persisted
      end

      it "redirects to the created ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        params = Factory.attributes_for(:ecol_remitter, :ecol_customer => ecol_customer)
        post :create, {:ecol_remitter => params}
        response.should redirect_to(EcolRemitter.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ecol_remitter as @ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        params = Factory.attributes_for(:ecol_remitter, :ecol_customer => ecol_customer)
        params[:customer_code] = nil
        expect {
          post :create, {:ecol_remitter => params}
        }.to change(EcolRemitter, :count).by(0)
        assigns(:ecol_remitter).should be_a(EcolRemitter)
        assigns(:ecol_remitter).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        ecol_customer = Factory(:ecol_customer)
        params = Factory.attributes_for(:ecol_remitter, :ecol_customer => ecol_customer)
        params[:customer_code] = nil
        post :create, {:ecol_remitter => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer, :customer_subcode => "CUST01")
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:customer_subcode] = "CUST02"
        put :update, {:id => ecol_remitter.id, :ecol_remitter => params}
        ecol_remitter.reload
        ecol_remitter.customer_subcode.should == "CUST02"
      end

      it "assigns the requested ecol_remitter as @ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer, :customer_subcode => "CUST01")
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:customer_subcode] = "CUST02"
        put :update, {:id => ecol_remitter.to_param, :ecol_remitter => params}
        assigns(:ecol_remitter).should eq(ecol_remitter)
      end

      it "redirects to the ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer, :customer_subcode => "CUST01")
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:customer_subcode] = "CUST02"
        put :update, {:id => ecol_remitter.to_param, :ecol_remitter => params}
        response.should redirect_to(ecol_remitter)
      end

      it "should raise error when tried to update at same time by many" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer, :customer_subcode => "CUST01")
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:customer_subcode] = "CUST02"
        ecol_remitter2 = ecol_remitter
        put :update, {:id => ecol_remitter.id, :ecol_remitter => params}
        ecol_remitter.reload
        ecol_remitter.customer_subcode.should == "CUST02"
        params[:customer_subcode] = "CUST03"
        put :update, {:id => ecol_remitter2.id, :ecol_remitter => params}
        ecol_remitter.reload
        ecol_remitter.customer_subcode.should == "CUST02"
        flash[:alert].should  match(/Someone edited the remitter the same time you did. Please re-apply your changes to the remitter/)
      end
    end

    describe "with invalid params" do
      it "assigns the ecol_remitter as @ecol_remitter" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer, :remitter_code => "01")
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:remitter_code] = nil
        put :update, {:id => ecol_remitter.to_param, :ecol_remitter => params}
        assigns(:ecol_remitter).should eq(ecol_remitter)
        ecol_remitter.reload
        params[:remitter_code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ecol_customer = Factory(:ecol_customer)
        ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer)
        params = ecol_remitter.attributes.slice(*ecol_remitter.class.attribute_names)
        params[:customer_code] = nil
        put :update, {:id => ecol_remitter.id, :ecol_remitter => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
 describe "GET audit_logs" do
   it "assigns the requested ecol_remitter as @ecol_remitter" do
     ecol_customer = Factory(:ecol_customer)
     ecol_remitter = Factory(:ecol_remitter, :ecol_customer => ecol_customer)
     get :audit_logs, {:id => ecol_remitter.id, :version_id => 0}
     assigns(:ecol_remitter).should eq(ecol_remitter)
     assigns(:audit).should eq(ecol_remitter.audits.first)
     get :audit_logs, {:id => 12345, :version_id => "i"}
     assigns(:ecol_remitter).should eq(nil)
     assigns(:audit).should eq(nil)
   end
 end

end
