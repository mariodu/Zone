class UsersController < ApplicationController
  before_filter :user_complete_info?, :only => [:update_complete_info, :complete_info]

  def index
  end

  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    password_changed = !params[:user][:password].empty?
    successfully_updated = if email_changed or password_changed
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    if successfully_updated
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to root_path
      else
        render "edit"
      end
    end


    def complete_info
      @user = current_user
      @user.email = ""
    end

    def update_complete_info
      if current_user.update_attributes(params[:user].merge(:complete_info => true))
        sign_in(@current_user, :bypass => true)
        redirect_to :root
      else
        render 'complete_info'
      end
    end

    def update
    end

    private

    def user_complete_info?
      redirect_to :root if current_user.complete_info
    end
  end