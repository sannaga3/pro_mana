class UsersController < ApplicationController
  def index
    friendships = current_user.active_friendships.pluck(:followed_id)
    @followed_users = User.find(friendships)
    @followed_users = Kaminari.paginate_array(@followed_users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @bmi = current_user.bmis.order(record_on: :desc).first if current_user.bmis != nil
  end
end
