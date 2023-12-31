ActiveAdmin.register AdminUser do
  permit_params :email, :username, :password, :password_confirmation, :remember_me, :inactive,:title, :body
  filter :id
  filter :email
  filter :username
  filter :inactive
  filter :created_at
  filter :updated_at
  filter :sign_in_count

  index do
    column :username
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :user_admin do |vt|
      if vt.id==current_admin_user.id
        (vt.has_role? :user_admin) ? "Yes" : "No"
      else
       (vt.has_role? :user_admin) ? (link_to "Remove User Admin", remove_user_admin_admin_admin_user_path(vt), :method => :put) : (link_to "Make User Admin", make_user_admin_admin_admin_user_path(vt), :method => :put)
      end
    end
    column :admin do |vt|
      if vt.id==current_admin_user.id
        (vt.has_role? :admin) ? "Yes" : "No"
      else
        (vt.has_role? :admin) ? (link_to "Remove Admin", remove_admin_admin_admin_user_path(vt), :method => :put) : (link_to "Make Admin", make_admin_admin_admin_user_path(vt), :method => :put)
      end
    end
    column :approver_admin do |vt|
      if vt.id==current_admin_user.id
        (vt.has_role? :approver_admin) ? "Yes" : "No"
      else
       (vt.has_role? :approver_admin) ? (link_to "Remove Approver Admin", remove_approver_admin_admin_admin_user_path(vt), :method => :put) : (link_to "Make Approver Admin", make_approver_admin_admin_admin_user_path(vt), :method => :put)
      end
    end
    column :inactive
    actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
      row :user_admin do |vt|
        if vt.id==current_admin_user.id
          (vt.has_role? :user_admin) ? "Yes" : "No"
        end
      end
      row :admin do |vt|
        if vt.id==current_admin_user.id
          (vt.has_role? :admin) ? "Yes" : "No"
        end
      end
      row :created_at
      row :updated_at
      row :username
    end
  end

  form do |f|
    @public_key = encrypted_field_public_key if @public_key.nil?
    f.hidden_field :public_key, value: @public_key, id: 'public_key'
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password, input_html: { data: { encrypt: true } }
      f.input :password_confirmation, input_html: { data: { encrypt: true } }
      f.input :inactive
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row "User Id" do |user|
        user.username
      end
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
      row :inactive
      row :created_at
      row :updated_at
    end
  end

  member_action :make_approver_admin, :method => :put do
    user = AdminUser.find(params[:id])
    if current_admin_user.has_role? :super_admin
      unless user.has_role?(:user_admin)
        user.add_role :approver_admin 
      else
        flash[:error] = "User with User admin access cannot be made an approver"
      end
    end
    #redirect_to :back
    redirect_back fallback_location: root_path
  end

  member_action :remove_approver_admin, :method => :put do
    user = AdminUser.find(params[:id])
    user.remove_role :approver_admin if current_admin_user.has_role? :super_admin
    redirect_to :back
  end

  member_action :make_user_admin, :method => :put do
    user = AdminUser.find(params[:id])
    if current_admin_user.has_role? :super_admin
      unless user.has_role?(:approver_admin)
        user.add_role :user_admin 
      else
        flash[:error] = "User with Approver admin access cannot be made an user"
      end
    end
    redirect_to :back
  end

  member_action :remove_user_admin, :method => :put do
    user = AdminUser.find(params[:id])
    user.remove_role :user_admin if current_admin_user.has_role? :super_admin
    #redirect_to :back
    redirect_back fallback_location: root_path
  end

  member_action :make_admin, :method => :put do
    user = AdminUser.find(params[:id])
    user.add_role :admin if current_admin_user.has_role? :super_admin
    #redirect_to :back
    redirect_back fallback_location: root_path
  end

  member_action :remove_admin, :method => :put do
    user = AdminUser.find(params[:id])
    user.remove_role :admin if current_admin_user.has_role? :super_admin
    redirect_to :back
  end
  
  controller do
    include EncryptedField::ControllerAdditions

    def create
      @admin_user = AdminUser.new(permitted_params[:admin_user])
      unless Rails.env.test?
        @admin_user.password = decrypt_encrypted_field(permitted_params[:admin_user][:password])
        #@admin_user.password_confirmation = decrypt_encrypted_field(permitted_params[:admin_user][:password_confirmation])
      end
      if !@admin_user.valid?
        render "new"
      else
        @admin_user.save!
        flash[:alert] = 'Admin User successfully created!'
        redirect_to :action => 'show', :id => @admin_user.id
      end
    end 

    def update
      @admin_user = AdminUser.find_by_id(params[:id])
      @admin_user.attributes = permitted_params[:admin_user]
      @admin_user.password = decrypt_encrypted_field(permitted_params[:admin_user][:password])
      #@admin_user.password_confirmation = decrypt_encrypted_field(permitted_params[:admin_user][:password_confirmation])
      if !@admin_user.valid?
        flash[:error] = @admin_user.errors.full_messages
        render "edit"
      else
        @admin_user.save!
        flash[:alert] = 'Admin User successfully modified!'
        redirect_to :action => 'show', :id => @admin_user.id
      end
      rescue ActiveRecord::StaleObjectError
        @admin_user.reload
        flash[:alert] = 'Someone edited the user the same time you did. Please re-apply your changes to the user.'
        render "edit"
    end
  end

  csv :download_links => true do
    column("Id") {|adminuser| adminuser.id}
    column("User Name") {|adminuser| adminuser.username}
    column("Email") {|adminuser| adminuser.email}
    column("Current Sign in at") {|adminuser| adminuser.current_sign_in_at}
    column("Last Sign in at") {|adminuser| adminuser.last_sign_in_at}
    column("Sign in count") {|adminuser| adminuser.sign_in_count}
    column("User Admin") {|adminuser|  (adminuser.has_role?(:user_admin))? "YES" : "NO"}
    column("Admin") {|adminuser| (adminuser.has_role?(:admin))? "YES" : "NO"}
    column("inactive") {|adminuser| adminuser.inactive}
    column("Created At") {|adminuser| adminuser.created_at}
    column("Updated At") {|adminuser| adminuser.updated_at}
  end
end
