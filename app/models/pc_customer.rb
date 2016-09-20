class PcCustomer < ActiveRecord::Base
  belongs_to :app, :foreign_key => 'app_id', :primary_key => 'app_id'
end
