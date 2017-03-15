class AddIamCustUsersForExistingCustomers < ActiveRecord::Migration
  def change
    Partner.unscoped.find_each(batch_size: 100) do |partner|
      unless partner.identity_user_id.nil?
        i = IamCustUser.find_by(username: partner.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: partner.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    FundsTransferCustomer.unscoped.find_each(batch_size: 100) do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    IcCustomer.unscoped.find_each(batch_size: 100) do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    PcApp.unscoped.find_each(batch_size: 100) do |app|
      unless app.identity_user_id.nil?
        i = IamCustUser.find_by(username: app.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: app.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    Pc2App.unscoped.find_each(batch_size: 100) do |app|
      unless app.identity_user_id.nil?
        i = IamCustUser.find_by(username: app.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: app.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    ImtCustomer.unscoped.find_each(batch_size: 100) do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    EcolCustomer.unscoped.find_each(batch_size: 100) do |customer|
      unless customer.identity_user_id.nil?
        i = IamCustUser.find_or_create_by(username: customer.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: customer.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
    SmBank.unscoped.find_each(batch_size: 100) do |bank|
      unless bank.identity_user_id.nil?
        i = IamCustUser.find_by(username: bank.identity_user_id, approval_status: 'A')
        IamCustUser.create(username: bank.identity_user_id, approval_status: 'A', skip_presence_validation: true) if i.nil?
      end
    end
  end
end
