class TopController < ApplicationController
  before_action :logged_in_user, only: []

  def index
  end
end
