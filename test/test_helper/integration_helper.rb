class ActionDispatch::IntegrationTest

  def user_login(user, password, redirected_to = nil)
    post "/users/sign_in", :user => {:email => user.email, :password => password}
    if redirected_to
      assert_redirected_to redirected_to
    else
      assert_redirected_to root_path
    end
  end

  def user_logout
    delete "/users/sign_out"
    assert_redirected_to root_path
  end
end