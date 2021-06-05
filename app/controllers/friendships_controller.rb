class FriendshipsController < ApplicationController
  class RelationshipsController < ApplicationController
    before_action :authenticate_user!
    respond_to? :js
    def create
      @user = User.find(params[:friendship][:followed_id])
      current_user.follow!(@user)
    end
  end

  def destroy
  end
end
