require 'spec_helper'

describe IcSuppliersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all ic_suppliers as @ic_suppliers" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      get :index
      assigns(:ic_suppliers).should eq([ic_supplier])
    end

    it "assigns all unapproved ic_suppliers as @ic_suppliers when approval_status is passed" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:ic_suppliers).should eq([ic_supplier])
    end
  end

  describe "GET show" do
    it "assigns the requested ic_supplier as @ic_supplier" do
      ic_supplier = Factory(:ic_supplier)
      get :show, {:id => ic_supplier.id}
      assigns(:ic_supplier).should eq(ic_supplier)
    end
  end

  describe "GET new" do
    it "assigns a new ic_supplier as @ic_supplier" do
      get :new
      assigns(:ic_supplier).should be_a_new(IcSupplier)
    end
  end

  describe "GET edit" do
    it "assigns the requested ic_supplier with status 'U' as @ic_supplier" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'U')
      get :edit, {:id => ic_supplier.id}
      assigns(:ic_supplier).should eq(ic_supplier)
    end

    it "assigns the requested ic_supplier with status 'A' as @ic_supplier" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      get :edit, {:id => ic_supplier.id}
      assigns(:ic_supplier).should eq(ic_supplier)
    end

    it "assigns the new ic_supplier with requested ic_supplier params when status 'A' as @ic_supplier" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      params = (ic_supplier.attributes).merge({:approved_id => ic_supplier.id, :approved_version => ic_supplier.lock_version})
      get :edit, {:id => ic_supplier.id}
      assigns(:ic_supplier).should eq(IcSupplier.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ic_supplier" do
        params = Factory.attributes_for(:ic_supplier)
        expect {
          post :create, {:ic_supplier => params}
        }.to change(IcSupplier.unscoped, :count).by(1)
        flash[:alert].should  match(/Instant Credit Supplier successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created ic_supplier as @ic_supplier" do
        params = Factory.attributes_for(:ic_supplier)
        post :create, {:ic_supplier => params}
        assigns(:ic_supplier).should be_a(IcSupplier)
        assigns(:ic_supplier).should be_persisted
      end

      it "redirects to the created ic_supplier" do
        params = Factory.attributes_for(:ic_supplier)
        post :create, {:ic_supplier => params}
        response.should redirect_to(IcSupplier.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ic_supplier as @ic_supplier" do
        params = Factory.attributes_for(:ic_supplier)
        params[:customer_id] = nil
        expect {
          post :create, {:ic_supplier => params}
        }.to change(IcSupplier, :count).by(0)
        assigns(:ic_supplier).should be_a(IcSupplier)
        assigns(:ic_supplier).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ic_supplier)
        params[:customer_id] = nil
        post :create, {:ic_supplier => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ic_supplier" do
        ic_supplier = Factory(:ic_supplier, :customer_id => "112233")
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_supplier.id, :ic_supplier => params}
        ic_supplier.reload
        ic_supplier.customer_id.should == "112234"
      end

      it "assigns the requested ic_supplier as @ic_supplier" do
        ic_supplier = Factory(:ic_supplier, :customer_id => "112233")
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_supplier.to_param, :ic_supplier => params}
        assigns(:ic_supplier).should eq(ic_supplier)
      end

      it "redirects to the ic_supplier" do
        ic_supplier = Factory(:ic_supplier, :customer_id => "112233")
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = "112234"
        put :update, {:id => ic_supplier.to_param, :ic_supplier => params}
        response.should redirect_to(ic_supplier)
      end

      it "should raise error when tried to update at same time by many" do
        ic_supplier = Factory(:ic_supplier, :customer_id => "112233")
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = "112234"
        ic_supplier2 = ic_supplier
        put :update, {:id => ic_supplier.id, :ic_supplier => params}
        ic_supplier.reload
        ic_supplier.customer_id.should == "112234"
        params[:customer_id] = "112235"
        put :update, {:id => ic_supplier2.id, :ic_supplier => params}
        ic_supplier.reload
        ic_supplier.customer_id.should == "112234"
        flash[:alert].should  match(/Someone edited the Instant Credit Supplier the same time you did. Please re-apply your changes to the Instant Credit Supplier/)
      end
    end

    describe "with invalid params" do
      it "assigns the ic_supplier as @ic_supplier" do
        ic_supplier = Factory(:ic_supplier, :customer_id => "112233")
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = nil
        put :update, {:id => ic_supplier.to_param, :ic_supplier => params}
        assigns(:ic_supplier).should eq(ic_supplier)
        ic_supplier.reload
        params[:customer_id] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ic_supplier = Factory(:ic_supplier)
        params = ic_supplier.attributes.slice(*ic_supplier.class.attribute_names)
        params[:customer_id] = nil
        put :update, {:id => ic_supplier.id, :ic_supplier => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested ic_supplier as @ic_supplier" do
      ic_supplier = Factory(:ic_supplier)
      get :audit_logs, {:id => ic_supplier.id, :version_id => 0}
      assigns(:ic_supplier).should eq(ic_supplier)
      assigns(:audit).should eq(ic_supplier.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:ic_supplier).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ic_supplier1 = Factory(:ic_supplier, :approval_status => 'A')
      ic_supplier2 = Factory(:ic_supplier, :approval_status => 'U', :customer_id => '112233', :approved_version => ic_supplier1.lock_version, :approved_id => ic_supplier1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      ic_supplier1.approval_status.should == 'A'
      IcUnapprovedRecord.count.should == 1
      put :approve, {:id => ic_supplier2.id}
      IcUnapprovedRecord.count.should == 0
      ic_supplier1.reload
      ic_supplier1.customer_id.should == '112233'
      ic_supplier1.updated_by.should == "666"
      IcUnapprovedRecord.find_by_id(ic_supplier2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      ic_supplier = Factory(:ic_supplier, :customer_id => '112233', :approval_status => 'U')
      IcUnapprovedRecord.count.should == 1
      put :approve, {:id => ic_supplier.id}
      IcUnapprovedRecord.count.should == 0
      ic_supplier.reload
      ic_supplier.customer_id.should == '112233'
      ic_supplier.approval_status.should == 'A'
    end
  end
end
