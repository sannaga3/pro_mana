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
    @user = Friendship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
