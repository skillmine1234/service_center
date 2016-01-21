class InwUnapprovedRecord < ActiveRecord::Base
  belongs_to :inw_approvable, :polymorphic => true, :unscoped => true
  INW_TABLES = ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwRemittanceRule','IncomingFile']
end