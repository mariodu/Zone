class Users::RegistrationsController < Devise::RegistrationsController
  def update
    binding.pry
    @user = User.find(current_user.id)
    params[:user].delete(:email) if params[:user][:email]
    successfully_updated = if params[:user][:password]
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      sign_in @user, :bypass => true
    else
      render :edit
    end
  end
end