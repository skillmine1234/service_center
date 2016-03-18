class EncryptedPasswordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  # before_filter :block_screens
  respond_to :json
  include ApplicationHelper

  def index
    @encrypted_passwords = EncryptedPassword.all
  end

  def new
    @encrypted_password = EncryptedPassword.new
  end

  def create
    @encrypted_password = EncryptedPassword.new(params[:encrypted_password])
    if !@encrypted_password.valid?
      render "new"
    else
      @encrypted_password.created_by = current_user.id
      @encrypted_password.save!
      flash[:alert] = 'Encrypted Password successfully created'
      redirect_to @encrypted_password
    end
  end

  def show
    @encrypted_password = EncryptedPassword.find(params[:id])
  end

  def edit
    @encrypted_password = EncryptedPassword.find(params[:id])
  end
  
  def update
    @encrypted_password = EncryptedPassword.find(params[:id])
    @encrypted_password.attributes = params[:encrypted_password]
    if !@encrypted_password.valid?
      render "edit"
    else
      @encrypted_password.save!
      flash[:alert] = 'Encrypted Password successfully modified'
      redirect_to @encrypted_password
    end
  end

  private

    def encrypted_password_params
      params.require(:encrypted_password).permit(:created_by, :password)
    end
end

