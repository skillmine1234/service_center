require 'spec_helper'

describe PcProductsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc_products as @pc_products" do
      pc_product = Factory(:pc_product, :approval_status => 'A')
      get :index
      assigns(:pc_products).should eq([pc_product])
    end
    
    it "assigns all unapproved pc_products as @pc_products when approval_status is passed" do
      pc_product = Factory(:pc_product)
      get :index, :approval_status => 'U'
      assigns(:pc_products).should eq([pc_product])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc_product as @pc_product" do
      pc_product = Factory(:pc_product)
      get :show, {:id => pc_product.id}
      assigns(:pc_product).should eq(pc_product)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc_product as @pc_product" do
      get :new
      assigns(:pc_product).should be_a_new(PcProduct)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc_product with status 'U' as @pc_product" do
      pc_product = Factory(:pc_product, :approval_status => 'U')
      get :edit, {:id => pc_product.id}
      assigns(:pc_product).should eq(pc_product)
    end

    it "assigns the requested pc_product with status 'A' as @pc_product" do
      pc_product = Factory(:pc_product,:approval_status => 'A')
      get :edit, {:id => pc_product.id}
      assigns(:pc_product).should eq(pc_product)
    end

    it "assigns the new pc_product with requested pc_product params when status 'A' as @pc_product" do
      pc_product = Factory(:pc_product,:approval_status => 'A')
      params = (pc_product.attributes).merge({:approved_id => pc_product.id,:approved_version => pc_product.lock_version})
      get :edit, {:id => pc_product.id}
      assigns(:pc_product).should eq(PcProduct.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc_product" do
        params = Factory.attributes_for(:pc_product)
        expect {
          post :create, {:pc_product => params}
        }.to change(PcProduct.unscoped, :count).by(1)
        flash[:alert].should  match(/PcProduct successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created pc_product as @pc_product" do
        params = Factory.attributes_for(:pc_product)
        post :create, {:pc_product => params}
        assigns(:pc_product).should be_a(PcProduct)
        assigns(:pc_product).should be_persisted
      end

      it "redirects to the created pc_product" do
        params = Factory.attributes_for(:pc_product)
        post :create, {:pc_product => params}
        response.should redirect_to(PcProduct.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc_product as @pc_product" do
        params = Factory.attributes_for(:pc_product)
        params[:mm_host] = nil
        expect {
          post :create, {:pc_product => params}
        }.to change(PcProduct, :count).by(0)
        assigns(:pc_product).should be_a(PcProduct)
        assigns(:pc_product).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc_product)
        params[:mm_host] = nil
        post :create, {:pc_product => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc_product" do
        pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products")
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_products"
        put :update, {:id => pc_product.id, :pc_product => params}
        pc_product.reload
        pc_product.mm_host.should == "http://localhost:3002/pc_products"
      end

      it "assigns the requested pc_product as @pc_product" do
        pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products")
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_products"
        put :update, {:id => pc_product.to_param, :pc_product => params}
        assigns(:pc_product).should eq(pc_product)
      end

      it "redirects to the pc_product" do
        pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products")
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_products"
        put :update, {:id => pc_product.to_param, :pc_product => params}
        response.should redirect_to(pc_product)
      end

      it "should raise error when tried to update at same time by many" do
        pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products")
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_products"
        pc_product2 = pc_product
        put :update, {:id => pc_product.id, :pc_product => params}
        pc_product.reload
        pc_product.mm_host.should == "http://localhost:3002/pc_products"
        params[:mm_host] = "http://localhost:3003/pc_products"
        put :update, {:id => pc_product2.id, :pc_product => params}
        pc_product.reload
        pc_product.mm_host.should == "http://localhost:3002/pc_products"
        flash[:alert].should  match(/Someone edited the pc_product the same time you did. Please re-apply your changes to the pc_product/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc_product as @pc_product" do
        pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products")
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = nil
        put :update, {:id => pc_product.to_param, :pc_product => params}
        assigns(:pc_product).should eq(pc_product)
        pc_product.reload
        params[:mm_host] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc_product = Factory(:pc_product)
        params = pc_product.attributes.slice(*pc_product.class.attribute_names)
        params[:mm_host] = nil
        put :update, {:id => pc_product.id, :pc_product => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc_product as @pc_product" do
      pc_product = Factory(:pc_product)
      get :audit_logs, {:id => pc_product.id, :version_id => 0}
      assigns(:pc_product).should eq(pc_product)
      assigns(:audit).should eq(pc_product.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "1"}
      assigns(:pc_product).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_product1 = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products", :approval_status => 'A')
      pc_product2 = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products", :approval_status => 'U' , :approved_version => pc_product1.lock_version, :approved_id => pc_product1.id, :created_by => 666, :mm_admin_host => "http://localhost:3000/pc_products")
      # the following line is required for reload to get triggered (TODO)
      pc_product1.approval_status.should == 'A'
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_product2.id}
      PcUnapprovedRecord.count.should == 0
      pc_product1.reload
      pc_product1.mm_admin_host.should == "http://localhost:3000/pc_products"
      pc_product1.updated_by.should == "666"
      PcProduct.find_by_id(pc_product2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_product = Factory(:pc_product, :mm_host => "http://localhost:3001/pc_products", :approval_status => 'U', :mm_admin_host => "http://localhost:3000/pc_products")
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_product.id}
      PcUnapprovedRecord.count.should == 0
      pc_product.reload
      pc_product.mm_admin_host.should == "http://localhost:3000/pc_products"
      pc_product.approval_status.should == 'A'
    end
  end
end