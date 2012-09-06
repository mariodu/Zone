class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!,  :only => [:edit, :update, :destroy, :update_password, :edit_password, :complete_info, :update_complete_info]
  before_filter :user_complete_info?, :only => [:update_complete_info, :complete_info]

  def update
    @user = User.find(current_user.id)
    params[:user].delete(:email) if params[:user][:email]
    if @user.update_without_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to :root
    else
      render :edit
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to :root
    else
      render :edit_password
    end
  end

  def complete_info
    @user = current_user
    @user.email = ""
  end

  def update_complete_info
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user].merge(:complete_info => true))
      sign_in(@user, :bypass => true)
      redirect_to :root
    else
      render :complete_info
    end
  end

  private

  def user_complete_info?
    redirect_to :root if current_user.complete_info
  end
end