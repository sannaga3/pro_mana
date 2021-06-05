class RecordsController < ApplicationController
  before_action :set_record, only: %i[ show edit update destroy ]

  def index
    @records = Record.all
    @records = @records.order(record_on: :desc)
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
    @record = Record.find(params[:id])
    @food = Food.find(@record.food_id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:ate, :record_on, :food_id ,:user_id)
  end
end
