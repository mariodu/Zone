require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user  = FactoryGirl.create(:user)
  end

  test "edit" do
    sign_in @user
    common_test_get :edit, 'edit'
  end

  test "update" do
    sign_in @user
    old_email = @user.email

    params = {
      name: "one",
      email: "email@example.com"
    }
    post :update, :user => params
    assert_redirected_to :root
    new_user = assigns(:user)

    assert_equal new_user.email, old_email
    assert_equal new_user.name, params[:name]
  end

  test "edit password" do
    sign_in @user
    common_test_get :edit_password, 'edit_password'
  end

  test "update password" do
    sign_in @user

    params = {
      current_password: "password",
      password: "new_password",
      password_confirmation: "new_password"
    }

    post :update_password, :user => params
    assert_redirected_to :root

    params.delete :current_password
    post :update_password, :user => params
    assert_template :edit_password
  end

  test "complete info" do
    sign_in @user
    common_test_get :complete_info, 'complete_info'
  end

  test "update complete info" do
    sign_in @user

    params = {
      email: "example@example.com",
      password: "new_password",
      password_confirmation: "new_password"
    }

    assert_equal false, @user.complete_info

    post :update_complete_info, :user => params

    assert_redirected_to :root
    new_user = assigns(:user)
    assert_equal params[:email], new_user.email

    assert_equal true, new_user.complete_info
  end
end