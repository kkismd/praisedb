class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'ログインして下さい'
      redirect_to login_path
    end
  end

  private def find_model(model_class, model_id)
    object = model_class.find_by(id: model_id, home_id: current_user.home_id)
    if object.blank?
      raise ActiveRecord::RecordNotFound.new("Couldn't find #{model_class} with 'id'=#{model_id}")
    end

    return object
  end
end
