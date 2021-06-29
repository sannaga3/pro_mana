class UsersController < ApplicationController
  def index
    friendships = Friendship.find_current_user(current_user.id).pluck(:followed_id)
    @followed_users = User.find(friendships)
    @followed_users = Kaminari.paginate_array(@followed_users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @bmi = Bmi.pick_user_id(@user.id).order(record_on: :desc)
    @bmi = @bmi.first unless @bmi.nil?
  end
end
