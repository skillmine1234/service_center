require 'spec_helper'

describe UdfAttributesController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET new" do
    it "assigns a new udf_attribute as @udf_attribute" do
      get :new
      assigns(:udf_attribute).should be_a_new(UdfAttribute)
    end
  end
  
  describe "GET show" do
    it "assigns the requested udf_attribute as @udf_attribute" do
      udf_attribute = Factory(:udf_attribute)
      get :show, {:id => udf_attribute.id}
      assigns(:udf_attribute).should eq(udf_attribute)
    end
  end
  
  describe "GET index" do
    it "assigns all udf_attributes as @udf_attributes" do
      udf_attribute = Factory(:udf_attribute)
      get :index
      assigns(:udf_attributes).should eq([udf_attribute])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested udf_attribute as @udf_attribute" do
      udf_attribute = Factory(:udf_attribute)
      get :edit, {:id => udf_attribute.id}
      assigns(:udf_attribute).should eq(udf_attribute)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new udf_attribute" do
        params = Factory.attributes_for(:udf_attribute)
        expect {
          post :create, {:udf_attribute => params}
        }.to change(UdfAttribute, :count).by(1)
        flash[:alert].should  match(/Udf successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created udf_attribute as @udf_attribute" do
        params = Factory.attributes_for(:udf_attribute)
        post :create, {:udf_attribute => params}
        assigns(:udf_attribute).should be_a(UdfAttribute)
        assigns(:udf_attribute).should be_persisted
      end

      it "redirects to the created udf_attribute" do
        params = Factory.attributes_for(:udf_attribute)
        post :create, {:udf_attribute => params}
        response.should redirect_to(UdfAttribute.last)
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved udf_attribute as @udf_attribute" do
        params = Factory.attributes_for(:udf_attribute)
        params[:class_name] = nil
        expect {
          post :create, {:udf_attribute => params}
        }.to change(UdfAttribute, :count).by(0)
        assigns(:udf_attribute).should be_a(UdfAttribute)
        assigns(:udf_attribute).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:udf_attribute)
        params[:class_name] = nil
        post :create, {:udf_attribute => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested udf_attribute" do
        udf_attribute = Factory(:udf_attribute, :class_name => "EcolRemitter")
        params = udf_attribute.attributes.slice(*udf_attribute.class.attribute_names)
        params[:class_name] = "EcolCustomer"
        put :update, {:id => udf_attribute.id, :udf_attribute => params}
        udf_attribute.reload
        udf_attribute.class_name.should == "EcolCustomer"
      end

      it "assigns the requested udf_attribute as @udf_attribute" do
        udf_attribute = Factory(:udf_attribute, :class_name => "EcolRemitter")
        params = udf_attribute.attributes.slice(*udf_attribute.class.attribute_names)
        params[:class_name] = "EcolCustomer"
        put :update, {:id => udf_attribute.to_param, :udf_attribute => params}
        assigns(:udf_attribute).should eq(udf_attribute)
      end

      it "redirects to the udf_attribute" do
        udf_attribute = Factory(:udf_attribute, :class_name => "EcolRemitter")
        params = udf_attribute.attributes.slice(*udf_attribute.class.attribute_names)
        params[:class_name] = "EcolCustomer"
        put :update, {:id => udf_attribute.to_param, :udf_attribute => params}
        response.should redirect_to(udf_attribute)
      end
    end

    describe "with invalid params" do
      it "assigns the udf_attribute as @udf_attribute" do
        udf_attribute = Factory(:udf_attribute, :class_name => "CUST01")
        params = udf_attribute.attributes.slice(*udf_attribute.class.attribute_names)
        params[:class_name] = nil
        put :update, {:id => udf_attribute.to_param, :udf_attribute => params}
        assigns(:udf_attribute).should eq(udf_attribute)
        udf_attribute.reload
        params[:class_name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        udf_attribute = Factory(:udf_attribute)
        params = udf_attribute.attributes.slice(*udf_attribute.class.attribute_names)
        params[:class_name] = nil
        put :update, {:id => udf_attribute.id, :udf_attribute => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
  
  describe "GET audit_logs" do
    it "assigns the requested udf_attribute as @udf_attribute" do
      udf_attribute = Factory(:udf_attribute)
      get :audit_logs, {:id => udf_attribute.id, :version_id => 0}
      assigns(:udf_attribute).should eq(udf_attribute)
      assigns(:audit).should eq(udf_attribute.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:udf_attribute).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
  
end
