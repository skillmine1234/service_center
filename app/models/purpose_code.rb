class PurposeCode < ActiveRecord::Base
  attr_accessible :code, :created_by, :daily_txn_limit, :description, :disallowedbenetypes, :disallowedremtypes, :is_enabled, :lock_version, :txn_limit, :updated_by
end
