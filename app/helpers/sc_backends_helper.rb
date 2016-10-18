module ScBackendsHelper
  def find_sc_backends(params)
    sc_backends = (params[:approval_status].present? and params[:approval_status] == 'U') ? ScBackend.unscoped : ScBackend
    sc_backends = sc_backends.where("code=?",params[:code]) if params[:code].present?
    sc_backends
  end
end
