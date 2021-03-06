class NutritionRecordsController < ApplicationController
  before_action :set_nutrition_record, only: %i[show edit update destroy]
  before_action :set_foods, only: %i[index show update my_daily]
  before_action :pick_foods, only: %i[new create]

  def index
    @nutrition_records = NutritionRecord.includes(:user)
    @nutrition_records = @nutrition_records.order(start_time: :desc).page(params[:page]).per(5)
  end

  def new
    @nutrition_record = NutritionRecord.new
    @nutrition_record.nutrition_record_lines.build
  end

  def create
    @nutrition_record = NutritionRecord.new(nutrition_record_params)
    if @nutrition_record.nutrition_record_lines.empty?
      flash.now[:alert] = t('alert.failed_add_record_blank')
      @nutrition_record.nutrition_record_lines.build
      render :new
      return
    elsif @nutrition_record.save
      redirect_to nutrition_record_path(@nutrition_record.id), notice: t('notice.add_record')
    else
      flash.now[:alert] = t('alert.failed_add_record')
      render :new
    end
  end

  def show
    current_user.foods.nil_check
  end

  def edit
    5.times do
      @nutrition_record.nutrition_record_lines.build
    end
    @food = Food.find(@nutrition_record.nutrition_record_lines[0].food_id)
    @foods = current_user.foods
  end

  def update
    if @nutrition_record.update(nutrition_record_params)
      redirect_to nutrition_record_path(@nutrition_record.id), notice: t('notice.edit_record')
    else
      flash.now[:alert] = t('alert.failed_edit_record_blank')
      render :edit
    end
  end

  def destroy
    @nutrition_record.destroy
    redirect_to request.referer, notice: t('notice.destroy_record')
  end

  def my_daily
    @nutrition_records = current_user.nutrition_records.order(start_time: :desc).page(params[:page]).per(5)
    @nutrition_record_lines = @nutrition_records.map { |line| line.nutrition_record_lines }
  end

  def my_calendar
    @calendar_elements = current_user.nutrition_records.order(start_time: :desc)
  end

  private

  def pick_foods
    @foods = current_user.foods
    @q = @foods.ransack(params[:q])
    @foods = @q.result(distinct: true)
  end

  def set_foods
    @foods = Food.includes(:user)
  end

  def set_nutrition_record
    @nutrition_record = NutritionRecord.find(params[:id])
  end

  def nutrition_record_params
    params.require(:nutrition_record).permit(:start_time, :user_id, nutrition_record_lines_attributes:
      %i[id ate nutrition_record_id food_id])
  end
end
