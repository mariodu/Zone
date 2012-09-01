require 'test_helper'

class OmniauthTest < ActionDispatch::IntegrationTest

  test "renren" do
    get '/users/auth/renren'

    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:renren]

    assert_redirected_to '/users/auth/renren/callback'
  end
end
