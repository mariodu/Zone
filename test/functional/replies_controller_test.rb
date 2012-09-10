require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  setup do
    @user  = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic, fonder: @user)
    @reply = FactoryGirl.create(:reply, user:   @user)
  end

  test 'edit' do
    sign_in @user
    common_test_get :edit, 'edit', id: @reply.id
  end

  test 'update' do
    sign_in @user
    params = {content: "new_content"}

    put :update, reply: params, id: @reply.id, return_to: topic_path(@topic)
    assert_equal assigns(:reply).content, params[:content]
  end

  test 'create' do
    sign_in @user
    params = {content: 'content'}

    post :create, reply: params, topic_id: @topic.id
  end
end