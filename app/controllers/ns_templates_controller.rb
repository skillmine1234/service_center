class NsTemplatesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Approval2::ControllerAdditions

  def new
    @ns_template = NsTemplate.new
  end

  def create
    @ns_template = NsTemplate.new(params[:ns_template])
    if !@ns_template.valid?
      render "edit"
    else
      @ns_template.created_by = current_user.id
      @ns_template.save!
      flash[:alert] = 'Template record successfully created and is pending for approval'
      redirect_to @ns_template
    end
  end

  def update
    @ns_template = NsTemplate.unscoped.find_by_id(params[:id])
    @ns_template.attributes = params[:ns_template]
    if !@ns_template.valid?
      render "edit"
    else
      @ns_template.updated_by = current_user.id
      @ns_template.save!
      flash[:alert] = 'Template record successfully modified successfully'
      redirect_to @ns_template
    end
    rescue ActiveRecord::StaleObjectError
      @ns_template.reload
      flash[:alert] = 'Someone edited the template the same time you did. Please re-apply your changes to the template.'
      render "edit"
  end 

  def show
    @ns_template = NsTemplate.unscoped.find_by_id(params[:id])
  end

  def index
    @ns_templates ||= NsTemplate.order("id desc").paginate(:per_page => 10, :page => params[:page])
  end
  
  def audit_logs
    @record = NsTemplate.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'ns')
  end

  private

  def ns_template_params
    params.require(:ns_template).permit(:lock_version, :last_action, :updated_by, :sc_event_id, :is_enabled, :sms_template, :email_template,
                                        :approval_status, :approved_version, :approved_id, :email_subject)
  end
end
