ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :password, :password_confirmation, :remember_me,
                :username, :inactive, :title, :body, :role_id, :mobile_no, :group_id
  filter :id
  filter :username, :label=>"User Id"
  filter :email
  filter :first_name
  filter :last_name
  filter :mobile_no
  filter :inactive,  as: :select
  filter :created_at
  filter :updated_at
  filter :sign_in_count
  filter :role
  filter :group

  index do
    column "Id" do |user|
      link_to "#{user.id}","users/#{user.id}"
    end
          column "User Id" do |user|
      user.username
    end
    column :first_name
    column :last_name
    column :email
    column :mobile_no
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :inactive
    column :role
    column :group
    actions
  end

  show do |ad|
    attributes_table do
      row "User Id" do |user|
        user.username
      end
      row :first_name
      row :last_name
      row :email
      row :mobile_no
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
      row :inactive
      row :role
      row :group
      row :created_at
      row :updated_at
    end
  end

  form :partial => "form"

  csv :download_links => true do
    column("Id") {|user| user.id}
    column("UserId") {|user| user.username}
    column("FirstName") {|user| user.first_name}
    column("LastName") {|user| user.last_name}
    column("Email") {|user| user.email}
    column("MobileNo") {|user| user.mobile_no}
    column("Current Sign In At") {|user| user.current_sign_in_at}
    column("Last sign In At") {|user| user.last_sign_in_at}
    column("Sign in count") {|user| user.sign_in_count}
    column("Inactive") {|user| user.inactive}
    column("Role") {|user| user.role}
    column("Group") {|user| user.group}
  end
end
