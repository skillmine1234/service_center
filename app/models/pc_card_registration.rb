class PcCardRegistration < ActiveRecord::Base
  belongs_to :app, :foreign_key => 'app_id', :primary_key => 'app_id', :class_name => 'PcApp'
end
