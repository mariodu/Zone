require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @user  = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic, fonder: @user)
  end

  test 'index' do
    common_test_get :index, 'index'
  end

  test 'show' do
    common_test_get :show, 'show', id: @topic.id
  end

  test 'new' do
    sign_in @user
    common_test_get :new, 'new'
  end

  test 'edit' do
    sign_in @user
    common_test_get :edit, 'edit', id: @topic.id
  end

  test 'create' do
    sign_in @user
    params = FactoryGirl.attributes_for(:topic)
    params.delete :fonder

    post :create, topic: params

    topic = assigns(:topic)
    assert topic, "no created topic!"
    assert_equal topic.fonder, @user
    assert_redirected_to topic
  end

  test 'update' do
    sign_in @user
    params = FactoryGirl.attributes_for(:topic, title: "test")
    params.delete :fonder

    put :update, topic: params, id: @topic.id

    topic = assigns(:topic)
    assert_equal topic.title, 'test'
    assert_redirected_to topic
  end
end