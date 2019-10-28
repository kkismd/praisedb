require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    log_in_as(@user)
    assert_difference('User.count') do
      post users_url, params: { user: { name: @user.name, password_digest: @user.password_digest, status: @user.status } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    log_in_as(@user)
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_url(@user), params: { user: { name: @user.name, password_digest: @user.password_digest, status: @user.status } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
