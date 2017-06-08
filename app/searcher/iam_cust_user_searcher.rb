class IamCustUserSearcher
  include ActiveModel::Validations
  attr_accessor :page, :username, :email, :mobile_no, :approval_status
  PER_PAGE = 10
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    if valid? 
      find.paginate(per_page: PER_PAGE, page: page)
    else
      IamCustUser.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private  
  def persisted?
    false
  end

  def find
    reln = approval_status == 'U' ? IamCustUser.unscoped.where("approval_status =?",'U').order("id desc") : IamCustUser.order("id desc")
    reln = reln.where("username=?", username) if username.present?
    reln = reln.where("email=?", email) if email.present?
    reln = reln.where("mobile_no=?", mobile_no) if mobile_no.present?
    reln
  end
end