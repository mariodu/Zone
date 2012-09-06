class ActionController::TestCase
  def user_login(user)
    assert user
    session[:user_id] = user.id
  end

  def common_test_get(action, template, params = {})
    get action, params
    assert_response :success
    assert_template template
  end
end