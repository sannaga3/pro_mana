class RecordsController < ApplicationController
  before_action :set_record, only: %i[ show edit update destroy ]
  before_action :set_food, only: %i[ show edit ]

  def index
    @records = Record.all
    @records = @records.order(record_on: :desc)
    @days = @records.pluck(:record_on)
    @days = @days.uniq
    @days = Kaminari.paginate_array(@days).page(params[:page]).per(5)
  end

  def new
    @record = Record.new
    @foods = Food.where(user_id: current_user.id)
    @q = @foods.ransack(params[:q])
    @foods = @q.result(distinct: true)
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to record_path(@record.id), notice: t('notice.add_record')
    else
      render :new
    end
  end

  def show
    @record = Record.find(params[:id])
  end

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to record_path(@record.id), notice: t('notice.edit_record')
    else
      render :new
    end
  end

  def destroy
    @record.destroy
    redirect_to request.referer, notice: t('notice.destroy_record')
  end

  def my_daily
    @records = Record.where(user_id: current_user.id)
    @records = @records.order(record_on: :desc)
    @days = @records.pluck(:record_on)
    @days = @days.uniq
    @days = Kaminari.paginate_array(@days).page(params[:page]).per(5)
  end

  private

  def set_food
    @food = Food.find(@record.food_id)
  end

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:ate, :record_on, :food_id ,:user_id)
  end
end
