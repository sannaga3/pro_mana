class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  def index
    @foods = Food.all
    @foods = @foods.where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
      if @food.save
        redirect_to foods_path, notice: t('notice.add_food')
      else
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to foods_path, notice: t('notice.edit_food')
    else
      render :new
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_path, notice: t('notice.destroy_food')
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :protain, :quantity, :unit, :user_id)
  end
end
