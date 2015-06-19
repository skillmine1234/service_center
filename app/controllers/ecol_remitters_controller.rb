class EcolRemittersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include EcolRemittersHelper
  
    def new
      @ecol_remitter = EcolRemitter.new
    end
  
    def create
      @ecol_remitter = EcolRemitter.new(params[:ecol_remitter])
      if !@ecol_remitter.valid?
        render "new"
      else
        @ecol_remitter.created_by = current_user.id
        @ecol_remitter.save
        flash[:alert] = 'Remitter successfully created'
        redirect_to @ecol_remitter
      end
    end
  
    def edit
      @ecol_remitter = EcolRemitter.find_by_id(params[:id])
    end
  
    def update
      @ecol_remitter = EcolRemitter.find_by_id(params[:id])
      @ecol_remitter.attributes = params[:ecol_remitter]
      if !@ecol_remitter.valid?
        render "edit"
      else
        @ecol_remitter.updated_by = current_user.id
        @ecol_remitter.save
        flash[:alert] = 'Remitter successfully modified'
        redirect_to @ecol_remitter
      end
      rescue ActiveRecord::StaleObjectError
        @ecol_remitter.reload
        flash[:alert] = 'Someone edited the remitter the same time you did. Please re-apply your changes to the remitter.'
        render "edit"
    end
  
    def show
      @ecol_remitter = EcolRemitter.find_by_id(params[:id])
    end
  
    def index
      ecol_remitters = filter_ecol_remitter(params)
      if params[:advanced_search].present?
        ecol_remitters = find_ecol_remitters(ecol_remitters,params).order("id desc")
      end
      @ecol_remitters_count = ecol_remitters.count
      @ecol_remitters = ecol_remitters.paginate(:per_page => 10, :page => params[:page]) rescue []
    end
  
    def audit_logs
      @ecol_remitter = EcolRemitter.find(params[:id]) rescue nil
      @audit = @ecol_remitter.audits[params[:version_id].to_i] rescue nil
    end
  
  
  private

  def ecol_remitter_params
    params.require(:ecol_remitter).permit(:incoming_file_id, :customer_code, :customer_subcode, :remitter_code,
    :ecol_customer_id, :credit_acct_no, :customer_subcode_email, :customer_subcode_mobile, :rmtr_name,
    :rmtr_address, :rmtr_acct_no, :rmtr_email, :rmtr_mobile, :invoice_no, :invoice_amt,
    :invoice_amt_tol_pct, :min_credit_amt, :max_credit_amt, :due_date, :due_date_tol_days, :udf1, :udf2, :udf3,
    :udf4, :udf5, :udf6, :udf7, :udf8, :udf9, :udf10, :udf11, :udf12, :udf13, :udf14, :udf15, :udf16, :udf17,
    :udf18, :udf19, :udf20, :created_by, :updated_by, :lock_version)
    
  end
  
end
