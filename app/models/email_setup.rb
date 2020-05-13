class EmailSetup < ActiveRecord::Base

	include Approval2::ModelAdditions
	
	belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
	belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'


	validates_presence_of :service_name,:app_id,:customer_id
	validates_uniqueness_of :app_id,:customer_id,:service_name, :scope => [:app_id,:service_name,:customer_id,:approval_status]
	validate :check_record_exist
	validate :email_entry

	def data_present?
		if self.service_name.present? && self.app_id.present? && self.customer_id.present?
			return true
		end
	end

	def check_record_exist

		@record_exist = false
		
		# @email_setup = EmailSetup.where(service_name: self.service_name,app_id: self.app_id,customer_id: self.customer_id)

		# if @email_setup.present?
		# 	@record_exist = true
		# 	self.errors.add(:base, "Record already exist for bellow APP ID & Customer ID")
		# end

		if @record_exist == false
			if self.service_name == "fund_transfer"
				@ft_records = FundsTransferCustomer.unscoped.where(app_id: self.app_id,customer_id: self.customer_id)
				if !@ft_records.present?
					self.errors.add(:base, "Yet not registered the Customer,first register it as FundsTransfer Customer.")
				end
			end
			if self.service_name == "inward_remitance"
				@partner_records = Partner.unscoped.where(code: self.app_id,customer_id: self.customer_id)
				if !@partner_records.present?
					self.errors.add(:base, "Yet not registered the Customer,first register it as Partner.")
				end
			end

			if self.service_name == "dealer_finance"
				@ic_cust_records = IcCustomer.unscoped.where(app_id: self.app_id,customer_id: self.customer_id)
				if !@ic_cust_records.present?
					self.errors.add(:base, "Yet not registered the Customer,first register it as Delear Finance Customer.")
				end
			end
		end
	end

	def email_entry
		if [self.email1, self.email2, self.email3, self.email4, self.email5].reject(&:blank?).size == 0
			self.errors.add(:email_error_base, "Please enter atleast one Email Address")
		elsif self.email1.present?
			validates_format_of :email1, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		elsif self.email2.present?
			validates_format_of :email2, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		elsif self.email3.present?
			validates_format_of :email3, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		elsif self.email4.present?
			validates_format_of :email4, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		elsif self.email5.present?
			validates_format_of :email5, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }						
		end
	end

	def email1_content
		data = self.email1.present? ? self.email1 : "-"
	end

	def email2_content
		data = self.email2.present? ? self.email2 : "-"
	end

	def email3_content
		data = self.email3.present? ? self.email3 : "-"
	end

	def email4_content
		data = self.email4.present? ? self.email4 : "-"
	end

	def email5_content
		data = self.email5.present? ? self.email5 : "-"
	end

	def self.data_search(service_name,app_id,customer_id)

		if service_name == "all"
			@records = EmailSetup.all
		else
			@records = EmailSetup.where(service_name: service_name) if service_name.present?
			@records = EmailSetup.where(app_id: app_id) if app_id.present?
			@records = EmailSetup.where(customer_id: customer_id) if customer_id.present?
		end
		
		return @records
	end

end