admin_users = AdminUser.seed(:username) do |a|
  a.username = "admin"
  a.email = "admin@example.com"
  a.password = "rootpassword"
  a.password_confirmation = "********"
end

admin_users[0].add_role :super_admin