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

if Role.all.empty?
  Role.create(:name=>"user")
end

if InwRemittanceRule.all.empty?
  InwRemittanceRule.create!(:pattern_salutations => "Mr,Mrs,Miss,Dr,Ms,PRof,Rev,Lady,Sir,Capt,Major,LtCol,Col")
end

if EcolRule.all.empty?  
  EcolRule.create(:ifsc => "QGPL0123456", :cod_acct_no => "0123456789", :stl_gl_inward => "123456789", :stl_gl_return => "123456789")
end