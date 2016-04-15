class Ability
  include CanCan::Ability

  def initialize(user_obj)
    # The order of the below methods are much important
    @user = user_obj
    @user ||= User.new # guest @user (not logged in)
    super_admin_permissions if @user.has_role? :super_admin
    admin_permissions if @user.has_role? :admin
    user_admin_permissions if @user.has_role? :user_admin
    approver_admin_permissions if @user.has_role? :approver_admin
    user_permissions(@user.group_model_list) if @user.has_role? :user
    editor_permissions(@user.group_model_list) if @user.has_role? :editor
    supervisor_permissions(@user.group_model_list) if @user.has_role? :supervisor
    tester_permissions(@user.group_model_list) if @user.has_role? :tester
    can :read, ActiveAdmin::Page, :name => "Dashboard"
  end

  def user_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
    end
  end

  def editor_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :manage, model_name.constantize
      cannot :approve, model_name.constantize
    end
  end

  def supervisor_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :approve, model_name.constantize
      can :hit_api, model_name.constantize
      can :destroy, model_name.constantize
      can :download_response_file, model_name.constantize
      can :skip_all_records, model_name.constantize
      can :approve_restart, model_name.constantize
      can :generate_response_file, model_name.constantize
    end
  end

  def tester_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :manage, model_name.constantize
    end
  end

  def user_admin_permissions
    can :manage, User
    cannot :destroy, User
    can :manage, AdminUser, :id=>@user.id
    cannot :destroy, AdminUser
    cannot :create, AdminUser
    can :manage, UserRole
    cannot :destroy, UserRole
    can :manage, UserGroup
    cannot :destroy, UserGroup
  end

  def admin_permissions
    can :read, User
    cannot :destroy, AdminUser
    cannot :create, AdminUser
  end

  def super_admin_permissions
    can :manage, AdminUser
    cannot :destroy, AdminUser, :id=>@user.id
  end

  def approver_admin_permissions
    can :read, UserRole
    can :approve, UserRole
    can :read, UserGroup
    can :approve, UserGroup
  end
end
