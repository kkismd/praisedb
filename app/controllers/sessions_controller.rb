class SessionsController < ApplicationController
  before_action :logged_in_user, only: []
  
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to :root
    else
      flash.now[:error] = '違います'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to :root
  end
end
