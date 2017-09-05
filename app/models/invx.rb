class Invx < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "invx_#{Rails.env}"
end