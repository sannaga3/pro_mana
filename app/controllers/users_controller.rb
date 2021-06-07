class UsersController < ApplicationController
  def index
    friendships = Friendship.where(follower_id: current_user.id).pluck(:followed_id)
    @followed_users = User.find(friendships)
    # binding.irb
  end

  def show
    @user = User.find(params[:id])
  end
end
