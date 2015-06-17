class UdfAttributesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def new
    @udf_attribute = UdfAttribute.new
  end

  def create
    @udf_attribute = UdfAttribute.new(params[:udf_attribute])
    if !@udf_attribute.valid?
      render "new"
    else
      @udf_attribute.save
      flash[:alert] = 'Udf successfully created'
      redirect_to @udf_attribute
    end
  end

  def edit
    @udf_attribute = UdfAttribute.find_by_id(params[:id])
  end

  def update
    @udf_attribute = UdfAttribute.find_by_id(params[:id])
    @udf_attribute.attributes = params[:udf_attribute]
    if !@udf_attribute.valid?
      render "edit"
    else
      @udf_attribute.save
      flash[:alert] = 'Udf successfully modified'
      redirect_to @udf_attribute
    end
    rescue ActiveRecord::StaleObjectError
      @udf_attribute.reload
      flash[:alert] = 'Someone edited the udf the same time you did. Please re-apply your changes to the udf.'
      render "edit"
  end

  def show
    @udf_attribute = UdfAttribute.find_by_id(params[:id])
  end

  def index
    udf_attributes = UdfAttribute.order("id desc")
    @udf_attributes_count = udf_attributes.count
    @udf_attributes = udf_attributes.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @udf_attribute = UdfAttribute.find(params[:id]) rescue nil
    @audit = @udf_attribute.audits[params[:version_id].to_i] rescue nil
  end


private

def udf_attribute_params
  params.require(:udf_attribute).permit(:class_name, :attribute_name, :label_text, :is_enabled, :is_mandatory, 
  :control_type, :data_type, :constraints, :select_options,:length, :max_length, :min_length, :min_value, 
  :max_value, :lock_version)
  
end
  
end
