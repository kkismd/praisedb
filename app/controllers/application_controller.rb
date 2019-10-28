class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'ログインして下さい'
      redirect_to login_path
    end
  end
end
