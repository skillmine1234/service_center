require 'spec_helper'

describe FpOperationsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all fp_operations as @fp_operations" do
      fp_operation = Factory(:fp_operation, :approval_status => 'A')
      get :index
      assigns(:fp_operations).should eq([fp_operation])
    end
    
    it "assigns all unapproved fp_operations as @fp_operations when approval_status is passed" do
      fp_operation = Factory(:fp_operation)
      get :index, :approval_status => 'U'
      assigns(:fp_operations).should eq([fp_operation])
    end
  end
  
  describe "GET show" do
    it "assigns the requested fp_operation as @fp_operation" do
      fp_operation = Factory(:fp_operation)
      get :show, {:id => fp_operation.id}
      assigns(:fp_operation).should eq(fp_operation)
    end
  end
  
  describe "GET new" do
    it "assigns a new fp_operation as @fp_operation" do
      get :new
      assigns(:fp_operation).should be_a_new(FpOperation)
    end
  end

  describe "GET edit" do
    it "assigns the requested fp_operation with status 'U' as @fp_operation" do
      fp_operation = Factory(:fp_operation, :approval_status => 'U')
      get :edit, {:id => fp_operation.id}
      assigns(:fp_operation).should eq(fp_operation)
    end

    it "assigns the requested fp_operation with status 'A' as @fp_operation" do
      fp_operation = Factory(:fp_operation,:approval_status => 'A')
      get :edit, {:id => fp_operation.id}
      assigns(:fp_operation).should eq(fp_operation)
    end

    it "assigns the new fp_operation with requested fp_operation params when status 'A' as @fp_operation" do
      fp_operation = Factory(:fp_operation,:approval_status => 'A')
      params = (fp_operation.attributes).merge({:approved_id => fp_operation.id,:approved_version => fp_operation.lock_version})
      get :edit, {:id => fp_operation.id}
      assigns(:fp_operation).should eq(FpOperation.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new fp_operation" do
        params = Factory.attributes_for(:fp_operation)
        expect {
          post :create, {:fp_operation => params}
        }.to change(FpOperation.unscoped, :count).by(1)
        flash[:alert].should  match(/FpOperation successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created fp_operation as @fp_operation" do
        params = Factory.attributes_for(:fp_operation)
        post :create, {:fp_operation => params}
        assigns(:fp_operation).should be_a(FpOperation)
        assigns(:fp_operation).should be_persisted
      end

      it "redirects to the created fp_operation" do
        params = Factory.attributes_for(:fp_operation)
        post :create, {:fp_operation => params}
        response.should redirect_to(FpOperation.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved fp_operation as @fp_operation" do
        params = Factory.attributes_for(:fp_operation)
        params[:operation_name] = nil
        expect {
          post :create, {:fp_operation => params}
        }.to change(FpOperation, :count).by(0)
        assigns(:fp_operation).should be_a(FpOperation)
        assigns(:fp_operation).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:fp_operation)
        params[:operation_name] = nil
        post :create, {:fp_operation => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested fp_operation" do
        fp_operation = Factory(:fp_operation, :operation_name => "App01")
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_operation.id, :fp_operation => params}
        fp_operation.reload
        fp_operation.operation_name.should == "App02"
      end

      it "assigns the requested fp_operation as @fp_operation" do
        fp_operation = Factory(:fp_operation, :operation_name => "App01")
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_operation.to_param, :fp_operation => params}
        assigns(:fp_operation).should eq(fp_operation)
      end

      it "redirects to the fp_operation" do
        fp_operation = Factory(:fp_operation, :operation_name => "App01")
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = "App02"
        put :update, {:id => fp_operation.to_param, :fp_operation => params}
        response.should redirect_to(fp_operation)
      end

      it "should raise error when tried to update at same time by many" do
        fp_operation = Factory(:fp_operation, :operation_name => "App01")
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = "App02"
        fp_operation2 = fp_operation
        put :update, {:id => fp_operation.id, :fp_operation => params}
        fp_operation.reload
        fp_operation.operation_name.should == "App02"
        params[:operation_name] = "App03"
        put :update, {:id => fp_operation2.id, :fp_operation => params}
        fp_operation.reload
        fp_operation.operation_name.should == "App02"
        flash[:alert].should  match(/Someone edited the fp_operation the same time you did. Please re-apply your changes to the fp_operation/)
      end
    end

    describe "with invalid params" do
      it "assigns the fp_operation as @fp_operation" do
        fp_operation = Factory(:fp_operation, :operation_name => "CUST01")
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = nil
        put :update, {:id => fp_operation.to_param, :fp_operation => params}
        assigns(:fp_operation).should eq(fp_operation)
        fp_operation.reload
        params[:operation_name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        fp_operation = Factory(:fp_operation)
        params = fp_operation.attributes.slice(*fp_operation.class.attribute_names)
        params[:operation_name] = nil
        put :update, {:id => fp_operation.id, :fp_operation => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested fp_operation as @fp_operation" do
      fp_operation = Factory(:fp_operation)
      get :audit_logs, {:id => fp_operation.id, :version_id => 0}
      assigns(:fp_operation).should eq(fp_operation)
      assigns(:audit).should eq(fp_operation.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:fp_operation).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      fp_operation1 = Factory(:fp_operation, :operation_name => "App01", :approval_status => 'A')
      fp_operation2 = Factory.build(:fp_operation, :operation_name => "App01", :approval_status => 'U', :approved_version => fp_operation1.lock_version, :approved_id => fp_operation1.id, :created_by => 666)
      fp_operation2.save.should == false
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      fp_operation = Factory(:fp_operation, :operation_name => "App01", :approval_status => 'U')
      FpUnapprovedRecord.count.should == 1
      put :approve, {:id => fp_operation.id}
      FpUnapprovedRecord.count.should == 0
      fp_operation.reload
      fp_operation.operation_name.should == 'App01'
      fp_operation.approval_status.should == 'A'
    end
  end
end
