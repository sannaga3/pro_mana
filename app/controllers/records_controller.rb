class RecordsController < ApplicationController
  def index
  end

  def new
    @record = Record.new
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to records_path, notice: "食品登録完了"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def record_params
    params.require(:record).permit(:ate, :date, :food_id ,:user_id)
  end
end
