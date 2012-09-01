class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def renren
    @user = User.find_for_renren_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "renren"
      session["renren.token"] = request.env['omniauth.auth']['credentials']['token']
      flash[:special] = "flash_consummate_info"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.renren_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end