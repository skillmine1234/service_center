require 'spec_helper'
require "cancan_matcher"

describe PartnersController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    @user.add_role :user
    request.env["HTTP_REFERER"] = "/"
  end

  describe "GET index" do
    it "assigns all partners as @partners" do
      partner = Factory(:partner)
      get :index
      assigns(:partners).should eq([partner])
    end
  end

  describe "GET show" do
    it "assigns the requested partner as @partner" do
      partner = Factory(:partner)
      get :show, {:id => partner.id}
      assigns(:partner).should eq(partner)
    end
  end

  describe "GET new" do
    it "assigns a new partner as @partner" do
      get :new
      assigns(:partner).should be_a_new(Partner)
    end
  end

  describe "GET edit" do
    it "assigns the requested partner as @partner" do
      partner = Factory(:partner)
      get :edit, {:id => partner.id}
      assigns(:partner).should eq(partner)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new partner" do
        params = Factory.attributes_for(:partner)
        expect {
          post :create, {:partner => params}
        }.to change(Partner, :count).by(1)
        flash[:alert].should  match(/Partner successfuly created/)
        response.should be_redirect
      end

      it "assigns a newly created partner as @partner" do
        params = Factory.attributes_for(:partner)
        post :create, {:partner => params}
        assigns(:partner).should be_a(Partner)
        assigns(:partner).should be_persisted
      end

      it "redirects to the created partner" do
        params = Factory.attributes_for(:partner)
        post :create, {:partner => params}
        response.should redirect_to(Partner.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved partner as @partner" do
        params = Factory.attributes_for(:partner)
        params[:code] = nil
        expect {
          post :create, {:partner => params}
        }.to change(Partner, :count).by(0)
        assigns(:partner).should be_a(Partner)
        assigns(:partner).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:partner)
        params[:code] = nil
        post :create, {:partner => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested partner" do
        partner = Factory(:partner, :code => "11")
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = "15"
        put :update, {:id => partner.id, :partner => params}
        partner.reload
        partner.code.should == "15"
      end

      it "assigns the requested partner as @partner" do
        partner = Factory(:partner, :code => "11")
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = "15"
        put :update, {:id => partner.to_param, :partner => params}
        assigns(:partner).should eq(partner)
      end

      it "redirects to the partner" do
        partner = Factory(:partner, :code => "11")
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = "15"
        put :update, {:id => partner.to_param, :partner => params}
        response.should redirect_to(partner)
      end

      it "should raise error when tried to update at same time by many" do
        partner = Factory(:partner, :code => "11")
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = "15"
        partner2 = partner
        put :update, {:id => partner.id, :partner => params}
        partner.reload
        partner.code.should == "15"
        params[:code] = "18"
        put :update, {:id => partner2.id, :partner => params}
        partner.reload
        partner.code.should == "15"
        flash[:alert].should  match(/Someone edited the partner the same time you did. Please re-apply your changes to the partner/)
      end
    end

    describe "with invalid params" do
      it "assigns the partner as @partner" do
        partner = Factory(:partner, :code => "11")
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = nil
        put :update, {:id => partner.to_param, :partner => params}
        assigns(:partner).should eq(partner)
        partner.reload
        params[:code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        partner = Factory(:partner)
        params = partner.attributes.slice(*partner.class.attribute_names)
        params[:code] = nil
        put :update, {:id => partner.id, :partner => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end

  describe "GET audit_logs" do
    it "assigns the requested partner as @partner" do
      partner = Factory(:partner)
      get :audit_logs, {:id => partner.id, :version_id => 0}
      assigns(:partner).should eq(partner)
      assigns(:audit).should eq(partner.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:partner).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end
