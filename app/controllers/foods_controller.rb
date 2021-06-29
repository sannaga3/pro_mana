class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  def index
    @foods = Food.all
    @foods = @foods.pick_user_id(current_user.id)
    @foods = @foods.order(id: :desc)
    @foods = Kaminari.paginate_array(@foods).page(params[:page]).per(10)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params_by_other_user)
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

  def food_params_by_other_user
    {
      name: params[:name],
      protein: params[:protein],
      quantity: params[:quantity],
      unit: params[:unit],
      user_id: params[:user_id]
    }
  end

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :protein, :quantity, :unit, :user_id)
  end
end
