require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'ログインに成功する' do
    get login_path
    post login_path, params: { session: { name: 'John', password: 'password' }}
    assert is_logged_in?
    assert_response :redirect
    follow_redirect!
    assert_response :success
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
  end

  test "ログインを間違う" do
    get login_path
    post login_path, params: { session: { name: 'hoge', password: 'fuga' }}
    # ログイン画面が描画される
    assert_select 'h1', 'Login'
    assert_not flash.empty?
    # 別画面に遷移するとフラッシュは消える
    get root_path
    assert flash.empty?
  end
end
