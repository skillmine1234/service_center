module IcSuppliersHelper
  def find_ic_suppliers(params)
    ic_suppliers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcSupplier.unscoped : IcSupplier
    ic_suppliers = ic_suppliers.where("supplier_code=?",params[:supplier_code]) if params[:supplier_code].present?
    ic_suppliers = ic_suppliers.where("supplier_name LIKE ?", "#{params[:supplier_name].upcase}%") if params[:supplier_name].present?
    ic_suppliers
  end
end
