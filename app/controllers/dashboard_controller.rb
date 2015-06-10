class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!

  include ActionView::Helpers::TextHelper
  respond_to :html, :js, :json, :xml

  def overview
    @current_user = current_user
  end
end
