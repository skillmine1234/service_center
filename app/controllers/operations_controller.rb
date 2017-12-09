class OperationsController < ApplicationController  
  def index
    authorize model_klass
    @searcher = searcher_klass.new(search_params)
    @records = decorator_klass.decorate_collection(policy_scope(@searcher).paginate) 
    render "#{view_path}/index"
  end

  def show
    authorize @record = model_klass.find(params[:id]).decorate
    render "#{view_path}/show"
  end

  def steps
    authorize record = model_klass.find(params[:id])
    @steps = decorator_klass.decorate_collection(record.audit_steps)
    render '/audit_steps/index'
  end

  private
  
  def view_path
    @view_path ||= request.path.split('/').second
  end
  
  def searcher_klass
    "#{model_klass.to_s + 'Searcher'}".constantize
  end
  
  def decorator_klass
    "#{model_klass.to_s + 'Decorator'}".constantize
  end
  
  def model_klass
    @model_klass ||= request.path.split('/').second.singularize.classify.constantize
  end
    
  def search_params
    if request.get?
      params.permit(:page)
    else
      pc = searcher_klass.to_s.tableize.singularize.to_sym
      params.require(pc).permit(searcher_klass.attributes)
    end
  end

  def protected_by_pundit
    true
  end
end