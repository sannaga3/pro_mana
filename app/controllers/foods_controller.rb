class FoodsController < ApplicationController
  
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
end
