require 'spec_helper'

describe EcolTransactionsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all ecol_transactions as @ecol_transactions" do
      ecol_transaction = Factory(:ecol_transaction)
      get :index
      assigns(:ecol_transactions).should eq([ecol_transaction])
    end
  end
  
  describe "GET show" do
    it "assigns the requested ecol_transaction as @ecol_transaction" do
      ecol_transaction = Factory(:ecol_transaction)
      get :show, {:id => ecol_transaction.id}
      assigns(:ecol_transaction).should eq(ecol_transaction)
    end
  end
  
  describe "GET new" do
    it "assigns a new ecol_transaction as @ecol_transaction" do
      get :new
      assigns(:ecol_transaction).should be_a_new(EcolTransaction)
    end
  end

  describe "GET edit" do
    it "assigns the requested ecol_transaction as @ecol_transaction" do
      ecol_transaction = Factory(:ecol_transaction)
      get :edit, {:id => ecol_transaction.id}
      assigns(:ecol_transaction).should eq(ecol_transaction)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ecol_transaction" do
        params = Factory.attributes_for(:ecol_transaction)
        expect {
          post :create, {:ecol_transaction => params}
        }.to change(EcolTransaction, :count).by(1)
        flash[:alert].should  match(/Transaction successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created ecol_transaction as @ecol_transaction" do
        params = Factory.attributes_for(:ecol_transaction)
        post :create, {:ecol_transaction => params}
        assigns(:ecol_transaction).should be_a(EcolTransaction)
        assigns(:ecol_transaction).should be_persisted
      end

      it "redirects to the created ecol_transaction" do
        params = Factory.attributes_for(:ecol_transaction)
        post :create, {:ecol_transaction => params}
        response.should redirect_to(EcolTransaction.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ecol_transaction as @ecol_transaction" do
        params = Factory.attributes_for(:ecol_transaction)
        params[:transfer_type] = nil
        expect {
          post :create, {:ecol_transaction => params}
        }.to change(EcolTransaction, :count).by(0)
        assigns(:ecol_transaction).should be_a(EcolTransaction)
        assigns(:ecol_transaction).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:ecol_transaction)
        params[:transfer_type] = nil
        post :create, {:ecol_transaction => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ecol_transaction" do
        ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD")
        params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
        params[:transfer_type] = "DAS"
        put :update, {:id => ecol_transaction.id, :ecol_transaction => params}
        ecol_transaction.reload
        ecol_transaction.transfer_type.should == "DAS"
      end

      it "assigns the requested ecol_transaction as @ecol_transaction" do
        ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD")
        params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
        params[:transfer_type] = "DAS"
        put :update, {:id => ecol_transaction.to_param, :ecol_transaction => params}
        assigns(:ecol_transaction).should eq(ecol_transaction)
      end

      it "redirects to the ecol_transaction" do
        ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD")
        params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
        params[:transfer_type] = "DAS"
        put :update, {:id => ecol_transaction.to_param, :ecol_transaction => params}
        response.should redirect_to(ecol_transaction)
      end
    end

    describe "with invalid params" do
      it "assigns the ecol_transaction as @ecol_transaction" do
        ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD")
        params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
        params[:transfer_type] = nil
        put :update, {:id => ecol_transaction.to_param, :ecol_transaction => params}
        assigns(:ecol_transaction).should eq(ecol_transaction)
        ecol_transaction.reload
        params[:transfer_type] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        ecol_transaction = Factory(:ecol_transaction)
        params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
        params[:transfer_type] = nil
        put :update, {:id => ecol_transaction.id, :ecol_transaction => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
  
  describe "GET summary" do
    it "renders summary" do
      ecol_transaction = Factory(:ecol_transaction, :status => 'NEW', :pending_approval => 'Y')
      get :summary
      assigns(:ecol_transaction_summary).should eq([[['NEW','Y'],1]])
      assigns(:ecol_transaction_statuses).should eq(['NEW','ALL'])
    end
  end 
  
  describe "POST edit_multiple" do
    it "assigns the requested ecol_transactions as @ecol_transactions" do
      ecol_transaction1 = Factory(:ecol_transaction, :transfer_unique_no => 'kjuioh')
      ecol_transaction2 = Factory(:ecol_transaction, :transfer_unique_no => 'kjuipp')
      ecol_transactions = [ecol_transaction1,ecol_transaction2]
      get :edit_multiple, {:ecol_transaction_ids => [ecol_transaction1.id,ecol_transaction2.id]}
      assigns(:ecol_transactions).should eq(ecol_transactions)
      
      get :edit_multiple, {:ecol_transaction_ids => []}
      assigns(:ecol_transactions).should_not eq(ecol_transactions)
    end
  end
  
  describe "PUT update_multiple" do
    it "updates the requested ecol_transactions" do
      ecol_transaction = Factory(:ecol_transaction, :transfer_unique_no => "vvvvv", :pending_approval => 'Y')
      params = ecol_transaction.attributes.slice(*ecol_transaction.class.attribute_names)
      params[:pending_approval] = "N"
      put :update_multiple, {:ecol_transaction_ids => [ecol_transaction.id], :ecol_transaction => params}
      response.should redirect_to(ecol_transactions_path)
      ecol_transaction.reload
      ecol_transaction.pending_approval.should == "N"
    end
  end

end
