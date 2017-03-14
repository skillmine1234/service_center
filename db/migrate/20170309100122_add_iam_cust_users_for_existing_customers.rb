class AddIamCustUsersForExistingCustomers < ActiveRecord::Migration
  def change
    Partner.unscoped.all.each do |partner|
      unless partner.identity_user_id.nil?
        i = IamCustUser.find_by(username: partner.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: partner.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    FundsTransferCustomer.unscoped.all.each do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    IcCustomer.unscoped.all.each do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    PcApp.unscoped.all.each do |app|
      unless app.identity_user_id.nil?
        i = IamCustUser.find_by(username: app.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: app.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    Pc2App.unscoped.all.each do |app|
      unless app.identity_user_id.nil?
        i = IamCustUser.find_by(username: app.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: app.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    ImtCustomer.unscoped.all.each do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    EcolCustomer.unscoped.all.each do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_or_create_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    SmBank.unscoped.all.each do |bank|
      unless bank.identity_user_id.nil?
        i = IamCustUser.find_by(username: bank.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: bank.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
  end
end
