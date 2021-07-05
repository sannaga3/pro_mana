class NutritionRecordsController < ApplicationController
  before_action :set_record, only: %i[show edit update destroy]
  before_action :set_food, only: %i[show edit]
  before_action :pick_foods, only: %i[new create]

  def index
    @records = NutritionRecord.all
    @records = @records.order(start_time: :desc)
    @days = @records.pluck(:start_time)
    @days = @days.uniq
    @days = Kaminari.paginate_array(@days).page(params[:page]).per(5)
  end

  def new
    @record = NutritionRecord.new
  end

  def create
    @record = NutritionRecord.new(nutrition_record_params)
    if @record.save
      redirect_to record_path(@record.id), notice: t('notice.add_record')
    else
      render :new
    end
  end

  def show
    @record = NutritionRecord.find(params[:id])
  end

  def edit; end

  def update
    if @record.update(nutrition_record_params)
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
    @records = NutritionRecord.pick_user_id(current_user.id)
    @records = @records.order(start_time: :desc)
    @days = @records.pluck(:start_time)
    @days = @days.uniq
    @days = Kaminari.paginate_array(@days).page(params[:page]).per(5)
    @foods = Food.all
  end

  private

  def pick_foods
    @foods = Food.where(user_id: current_user.id)
    @q = @foods.ransack(params[:q])
    @foods = @q.result(distinct: true)
  end

  def set_food
    @food = Food.find(@record.food_id)
  end

  def set_record
    @record = NutritionRecord.find(params[:id])
  end

  def record_params
    params.require(:nutrition_record).permit(:ate, :start_time, :food_id, :user_id)
  end
end
