class TopController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    redirect_to user_path(current_user.id) if current_user
  end
end
