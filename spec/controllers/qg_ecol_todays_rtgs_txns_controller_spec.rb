require 'spec_helper'

describe QgEcolTodaysRtgsTxnsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'tester').id)
    request.env["HTTP_REFERER"] = "/"
  end


  describe "GET index" do
    it "assigns all qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
      qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn)
      get :index
      assigns(:qg_ecol_todays_rtgs_txns).should eq([qg_ecol_todays_rtgs_txn])
    end
  end

  describe "GET show" do
    it "assigns the requested qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
      qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn)
      get :show, {:id => qg_ecol_todays_rtgs_txn.id}
      assigns(:qg_ecol_todays_rtgs_txn).should eq(qg_ecol_todays_rtgs_txn)
    end
  end

  describe "GET new" do
    it "assigns a new qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
      get :new
      assigns(:qg_ecol_todays_rtgs_txn).should be_a_new(QgEcolTodaysRtgsTxn)
    end
  end

  describe "GET edit" do
    it "assigns the requested qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
      @qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn)
      get :edit, {:id => @qg_ecol_todays_rtgs_txn.id}
      assigns(:qg_ecol_todays_rtgs_txn).should eq(@qg_ecol_todays_rtgs_txn)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new qg_ecol_todays_rtgs_txn" do
        params = Factory.attributes_for(:qg_ecol_todays_rtgs_txn)
        expect {
          post :create, {:qg_ecol_todays_rtgs_txn => params}
        }.to change(QgEcolTodaysRtgsTxn.all, :count).by(1)
        flash[:alert].should  match(/Qg Ecol Todays RTGS Transaction successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
        params = Factory.attributes_for(:qg_ecol_todays_rtgs_txn)
        post :create, {:qg_ecol_todays_rtgs_txn => params}
        assigns(:qg_ecol_todays_rtgs_txn).should be_a(QgEcolTodaysRtgsTxn)
        assigns(:qg_ecol_todays_rtgs_txn).should be_persisted
      end

      it "redirects to the created qg_ecol_todays_rtgs_txn" do
        params = Factory.attributes_for(:qg_ecol_todays_rtgs_txn)
        post :create, {:qg_ecol_todays_rtgs_txn => params}
        response.should redirect_to(QgEcolTodaysRtgsTxn.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
        params = Factory.attributes_for(:qg_ecol_todays_rtgs_txn)
        params[:idfcatref] = nil
        expect {
          post :create, {:qg_ecol_todays_rtgs_txn => params}
        }.to change(QgEcolTodaysRtgsTxn.all, :count).by(0)
        assigns(:qg_ecol_todays_rtgs_txn).should be_a(QgEcolTodaysRtgsTxn)
        assigns(:qg_ecol_todays_rtgs_txn).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:qg_ecol_todays_rtgs_txn)
        params[:idfcatref] = nil
        post :create, {:qg_ecol_todays_rtgs_txn => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested qg_ecol_todays_rtgs_txn" do
        qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn, :transfer_type => "ABC")
        params = qg_ecol_todays_rtgs_txn.attributes.slice(*qg_ecol_todays_rtgs_txn.class.attribute_names)
        params[:transfer_type] = "ABC"
        put :update, {:id => qg_ecol_todays_rtgs_txn.id, :qg_ecol_todays_rtgs_txn => params}
        qg_ecol_todays_rtgs_txn.reload
        qg_ecol_todays_rtgs_txn.transfer_type.should == "ABC"
      end

      it "assigns the requested qg_ecol_todays_rtgs_txn as @qg_ecol_todays_rtgs_txn" do
        qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn, :transfer_type => "ABC")
        params = qg_ecol_todays_rtgs_txn.attributes.slice(*qg_ecol_todays_rtgs_txn.class.attribute_names)
        params[:transfer_type] = "ABC"
        put :update, {:id => qg_ecol_todays_rtgs_txn.to_param, :qg_ecol_todays_rtgs_txn => params}
        assigns(:qg_ecol_todays_rtgs_txn).should eq(qg_ecol_todays_rtgs_txn)
      end

      it "redirects to the qg_ecol_todays_rtgs_txn" do
        qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn, :transfer_type => "ABC")
        params = qg_ecol_todays_rtgs_txn.attributes.slice(*qg_ecol_todays_rtgs_txn.class.attribute_names)
        params[:transfer_type] = "ABC"
        put :update, {:id => qg_ecol_todays_rtgs_txn.to_param, :qg_ecol_todays_rtgs_txn => params}
        response.should redirect_to(qg_ecol_todays_rtgs_txn)
      end
    end
  end

  describe "destroy" do
    it "should destroy the qg_ecol_todays_rtgs_txn" do 
      qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn)
      expect {delete :destroy, {:id => qg_ecol_todays_rtgs_txn.id}}.to change(QgEcolTodaysRtgsTxn, :count).by(-1)
    end


    it "redirects to the qg_ecol_todays_rtgs_txn list" do
      qg_ecol_todays_rtgs_txn = Factory(:qg_ecol_todays_rtgs_txn)
      delete :destroy, {:id => qg_ecol_todays_rtgs_txn.id}
      response.should redirect_to(qg_ecol_todays_rtgs_txns_url)
    end
  end

end