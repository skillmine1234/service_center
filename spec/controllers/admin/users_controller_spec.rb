require 'spec_helper'
require "cancan_matcher"
# include Devise::TestHelpers

describe Admin::UsersController do
  render_views

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @admin_user = FactoryGirl.create(:admin_user, :email => "test@gmail.com", :password => "password")
    @admin_user.add_role(:user_admin)
    request.env["HTTP_REFERER"] = "/"
  end

  context "create" do
    it 'should create user' do
      user = FactoryGirl.build(:user)
      params = {username: user.username, password: 'password123', email: user.email}
      post :create, :user => params
      expect(response).to be_redirect
      flash[:alert].should  match(/User successfully created!/)
    end
  end

  context "update" do
    it 'should update user' do
      user = FactoryGirl.create(:user)
      put :update, :id => user.id, :user => {:receive_sms => false}
      expect(response).to be_redirect
      flash[:alert].should  match(/User successfully modified!/)
    end
  end
end
