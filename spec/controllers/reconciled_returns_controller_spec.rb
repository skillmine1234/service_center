require 'spec_helper'

describe ReconciledReturnsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all reconciled_returns as @reconciled_returns" do
      reconciled_return = Factory(:reconciled_return)
      get :index
      assigns(:reconciled_returns).should eq([reconciled_return])
    end
  end
  
  describe "GET show" do
    it "assigns the requested reconciled_return as @reconciled_return" do
      reconciled_return = Factory(:reconciled_return)
      get :show, {:id => reconciled_return.id}
      assigns(:reconciled_return).should eq(reconciled_return)
    end
  end

  describe "GET new" do
    it "assigns a new reconciled_return as @reconciled_return" do
      get :new
      assigns(:reconciled_return).should be_a_new(ReconciledReturn)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new reconciled_return" do
        params = Factory.attributes_for(:reconciled_return)
        expect {
          post :create, {:reconciled_return => params}
        }.to change(ReconciledReturn, :count).by(1)
        flash[:alert].should  match(/Reconciled Return successfully created./)
        response.should be_redirect
      end

      it "assigns a newly created reconciled_return as @reconciled_return" do
        params = Factory.attributes_for(:reconciled_return)
        post :create, {:reconciled_return => params}
        assigns(:reconciled_return).should be_a(ReconciledReturn)
        assigns(:reconciled_return).should be_persisted
      end

      it "redirects to the created reconciled_return" do
        params = Factory.attributes_for(:reconciled_return)
        post :create, {:reconciled_return => params}
        response.should redirect_to(ReconciledReturn.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reconciled_return as @reconciled_return" do
        params = Factory.attributes_for(:reconciled_return)
        params[:return_code_type] = nil
        expect {
          post :create, {:reconciled_return => params}
        }.to change(ReconciledReturn, :count).by(0)
        assigns(:reconciled_return).should be_a(ReconciledReturn)
        assigns(:reconciled_return).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:reconciled_return)
        params[:return_code_type] = nil
        post :create, {:reconciled_return => params}
        response.should render_template("new")
      end
    end
  end

end
