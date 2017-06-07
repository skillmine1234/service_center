class IamCustUsersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json  
  include ApplicationHelper
  include Approval2::ControllerAdditions
  
  def new
    @iam_cust_user = IamCustUser.new
    @iam_cust_user.will_connect_to_ldap
  end

  def create
    @iam_cust_user = IamCustUser.new(params[:iam_cust_user])
    if !@iam_cust_user.valid?
      render "new"
    else
      @iam_cust_user.created_by = current_user.id
      @iam_cust_user.save!
      flash[:alert] = "User successfully created is pending for approval"
      redirect_to @iam_cust_user
    end
  end
  
  def edit
    @iam_cust_user.will_connect_to_ldap
  end

  def update
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @iam_cust_user.attributes = params[:iam_cust_user]
    if !@iam_cust_user.valid?
      render "edit"
    else
      @iam_cust_user.updated_by = current_user.id
      @iam_cust_user.save!
      flash[:alert] = 'User successfully modified and is pending for approval'
      redirect_to @iam_cust_user
    end
    rescue ActiveRecord::StaleObjectError
      @iam_cust_user.reload
      flash[:alert] = 'Someone edited the user the same time you did. Please re-apply your changes to the user.'
      render "edit"
  end

  def show
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @ldap_error = @iam_cust_user.will_connect_to_ldap
  end
  
  def index
    if request.get?
      @searcher = IamCustUserSearcher.new(params.permit(:approval_status, :page))
    else
      @searcher = IamCustUserSearcher.new(search_params)
    end
    @iam_cust_users = @searcher.paginate
  end

  def audit_logs
    @iam_cust_user = IamCustUser.unscoped.find(params[:id]) rescue nil
    @audit = @iam_cust_user.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'iam')
  end

  def connect_to_ldap
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    if params[:add_user]
      @message = @iam_cust_user.add_user_to_ldap
    elsif params[:resend_password]
      @message = @iam_cust_user.resend_password
    elsif params[:delete_user]
      @message = @iam_cust_user.delete_user_from_ldap
    else
      @message = @iam_cust_user.test_ldap_login
    end
    respond_to do |format|
      format.js {render file: 'iam_cust_users/message.js.haml'}
    end
  end

  private

  def search_params
    params.permit(:page, :username, :email, :mobile_no, :approval_status)
  end

  def iam_cust_user_params
    params.require(:iam_cust_user).permit(:username, :first_name, :last_name, :email, :mobile_no, :last_password_reset_at, 
                                          :created_at, :updated_at, :created_by, :updated_by, :lock_version, :approved_id, :approved_version,
                                          :lock_version, :should_reset_password, :is_enabled)
  end
end