class IamOrganisationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json  
  include ApplicationHelper
  include Approval2::ControllerAdditions
  
  def new
    @iam_organisation = IamOrganisation.new
  end

  def create
    @iam_organisation = IamOrganisation.new(params[:iam_organisation])
    if !@iam_organisation.valid?
      render "new"
    else
      @iam_organisation.created_by = current_user.id
      @iam_organisation.save!
      flash[:alert] = "Organisation successfully created is pending for approval"
      redirect_to @iam_organisation
    end
  end

  def update
    @iam_organisation = IamOrganisation.unscoped.find_by_id(params[:id])
    @iam_organisation.attributes = params[:iam_organisation]
    if !@iam_organisation.valid?
      render "edit"
    else
      @iam_organisation.updated_by = current_user.id
      @iam_organisation.save!
      flash[:alert] = 'Organisation successfully modified and is pending for approval'
      redirect_to @iam_organisation
    end
    rescue ActiveRecord::StaleObjectError
      @iam_organisation.reload
      flash[:alert] = 'Someone edited the organisation the same time you did. Please re-apply your changes to the organisation.'
      render "edit"
  end

  def show
    @iam_organisation = IamOrganisation.unscoped.find_by_id(params[:id])
  end
  
  def index
    if request.get?
      @searcher = IamOrganisationSearcher.new(params.permit(:approval_status, :page))
    else
      @searcher = IamOrganisationSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end

  def audit_logs
    @iam_organisation = IamOrganisation.unscoped.find(params[:id]) rescue nil
    @audit = @iam_organisation.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'iam')
  end

  private

  def search_params
    params.permit(:page, :name, :org_uuid, :approval_status)
  end

  def iam_organisation_params
    params.require(:iam_organisation).permit(:name, :email_id, :org_uuid, :on_vpn, :cert_dn, :source_ips, :is_enabled, :approval_status, :last_action, 
                                             :approved_id, :approved_version, :created_by, :updated_by, :created_at, :updated_at, :lock_version)
  end
end