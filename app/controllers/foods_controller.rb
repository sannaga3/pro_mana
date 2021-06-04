class FoodsController < ApplicationController

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

  def food_params
    params.require(:food).permit(:name, :protain, :quantity, :unit)
  end
end
