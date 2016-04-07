class IcUnapprovedRecord < ActiveRecord::Base
  belongs_to :ic_approvable, :polymorphic => true, :unscoped => true
  IC_TABLES = ['IcCustomer', 'IcSupplier']
end