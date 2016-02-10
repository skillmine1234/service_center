admin_users = AdminUser.seed(:username) do |admin_user|
  admin_user.username = "admin"
  admin_user.email = "admin@example.com"
  admin_user.password = "rootpassword"
  admin_user.password_confirmation = "rootpassword"
end

admin_users[0].add_role :super_admin