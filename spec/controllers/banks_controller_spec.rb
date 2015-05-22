require 'spec_helper'
require "cancan_matcher"

describe BanksController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all banks as @banks" do
      bank = Factory(:bank)
      get :index
      assigns(:banks).should eq([bank])
    end
  end

  describe "GET show" do
    it "assigns the requested bank as @bank" do
      bank = Factory(:bank)
      get :show, {:id => bank.id}
      assigns(:bank).should eq(bank)
    end
  end

  describe "GET new" do
    it "assigns a new bank as @bank" do
      get :new
      assigns(:bank).should be_a_new(Bank)
    end
  end

  describe "GET edit" do
    it "assigns the requested bank as @bank" do
      bank = Factory(:bank)
      get :edit, {:id => bank.id}
      assigns(:bank).should eq(bank)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new bank" do
        params = Factory.attributes_for(:bank)
        expect {
          post :create, {:bank => params}
        }.to change(Bank, :count).by(1)
        flash[:alert].should  match(/Bank successfuly created/)
        response.should be_redirect
      end

      it "assigns a newly created bank as @bank" do
        params = Factory.attributes_for(:bank)
        post :create, {:bank => params}
        assigns(:bank).should be_a(Bank)
        assigns(:bank).should be_persisted
      end

      it "redirects to the created bank" do
        params = Factory.attributes_for(:bank)
        post :create, {:bank => params}
        response.should redirect_to(Bank.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bank as @bank" do
        params = Factory.attributes_for(:bank)
        params[:name] = nil
        expect {
          post :create, {:bank => params}
        }.to change(Bank, :count).by(0)
        assigns(:bank).should be_a(Bank)
        assigns(:bank).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:bank)
        params[:name] = nil
        post :create, {:bank => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bank" do
        bank = Factory(:bank, :name => "11")
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = "15"
        put :update, {:id => bank.id, :bank => params}
        bank.reload
        bank.name.should == "15"
      end

      it "assigns the requested bank as @bank" do
        bank = Factory(:bank, :name => "11")
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = "15"
        put :update, {:id => bank.to_param, :bank => params}
        assigns(:bank).should eq(bank)
      end

      it "redirects to the bank" do
        bank = Factory(:bank, :name => "11")
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = "15"
        put :update, {:id => bank.to_param, :bank => params}
        response.should redirect_to(bank)
      end

      it "should raise error when tried to update at same time by many" do
        bank = Factory(:bank, :name => "11")
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = "15"
        bank2 = bank
        put :update, {:id => bank.id, :bank => params}
        bank.reload
        bank.name.should == "15"
        params[:name] = "18"
        put :update, {:id => bank2.id, :bank => params}
        bank.reload
        bank.name.should == "15"
        flash[:alert].should  match(/Someone edited the bank the same time you did. Please re-apply your changes to the bank/)
      end
    end

    describe "with invalid params" do
      it "assigns the bank as @bank" do
        bank = Factory(:bank, :name => "11")
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = nil
        put :update, {:id => bank.to_param, :bank => params}
        assigns(:bank).should eq(bank)
        bank.reload
        params[:name] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        bank = Factory(:bank)
        params = bank.attributes.slice(*bank.class.attribute_names)
        params[:name] = nil
        put :update, {:id => bank.id, :bank => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested bank as @bank" do
      bank = Factory(:bank)
      get :audit_logs, {:id => bank.id, :version_id => 0}
      assigns(:bank).should eq(bank)
      assigns(:audit).should eq(bank.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:bank).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end
