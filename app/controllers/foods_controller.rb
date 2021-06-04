class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
      if @food.save
        redirect_to foods_path, notice: "食品登録完了"
      else
        render :new
      end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to foods_path, notice: "食品編集完了"
    else
      render :new
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :protain, :quantity, :unit)
  end
end
