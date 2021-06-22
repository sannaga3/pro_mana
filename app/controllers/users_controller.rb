class UsersController < ApplicationController
  def index
    friendships = Friendship.find_current_user(current_user.id).pluck(:followed_id)
    @followed_users = User.find(friendships)
    @followed_users = Kaminari.paginate_array(@followed_users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end
end
