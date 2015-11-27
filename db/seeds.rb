# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if AdminUser.all.empty?
  admin = AdminUser.new(username: "admin", email: "admin@example.com", password: "rootpassword",
                        password_confirmation: "rootpassword")
  if admin.save
    admin.add_role :super_admin
  end
end

AdminRole.create(:name => 'approver_admin') if AdminRole.find_by_name("approver_admin").nil?

Role.create(:name => "user") if Role.find_by_name("user").nil?
Role.create(:name => "editor") if Role.find_by_name("editor").nil?
Role.create(:name => "supervisor") if Role.find_by_name("supervisor").nil?

Group.create(:name => "inward-remittance") if Group.find_by_name("inward-remittance").nil?
Group.create(:name => "e-collect") if Group.find_by_name("e-collect").nil?
Group.create(:name => "bill-management") if Group.find_by_name("bill-management").nil?


unless Rails.env == 'production'
  if InwRemittanceRule.all.empty?
    InwRemittanceRule.create!(:pattern_salutations => "Mr\r\nMrs\r\nMiss\r\nDr\r\nMs\r\nPRof\r\nRev\r\nLady\r\nSir\r\nCapt\r\nMajor\r\nLtCol\r\nCol", :approval_status => 'A')
  end

  if EcolRule.all.empty?
    EcolRule.create(:ifsc => "QGPL0123456", :cod_acct_no => "0123456789", :stl_gl_inward => "123456789", :approval_status => 'A',
                    :neft_sender_ifsc => "ABCD0123456", :customer_id => "QWEASD")
  end

  if ScService.all.empty?
    ScService.create(:code => 'AML', :name => 'Anti Money Laundering')
    ScService.create(:code => 'ECOL', :name => 'Ecollect')
  end

  if BmRule.all.empty?
    BmRule.create(:cod_acct_no => "0123456789", :customer_id => "QWEASD", :bene_acct_no => "0123456788", :bene_account_ifsc => "IFSC0123456", :neft_sender_ifsc => 'IFSC0123456', :approval_status => 'A')
  end

  if IncomingFileType.all.empty? and !ScService.all.empty?
    sc1 = ScService.find_by_code("AML")
    sc2 = ScService.find_by_code("ECOL")
    IncomingFileType.create(:sc_service_id => sc1.id, :code => 'SDN', :name => 'Specially Designated Individuals')
    IncomingFileType.create(:sc_service_id => sc1.id, :code => 'OFAC', :name => 'Office of Foreign Assets Control')
    IncomingFileType.create(:sc_service_id => sc2.id, :code => 'RMTRS', :name => 'Remitters')
  end
end
