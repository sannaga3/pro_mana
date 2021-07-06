class NutritionRecordsController < ApplicationController
  before_action :set_record, only: %i[show edit update destroy]
  before_action :set_foods, only: %i[index my_daily]
  before_action :pick_foods, only: %i[new create]

  def index
    @nutrition_records = current_user.nutrition_records.order(start_time: :desc).page(params[:page]).per(5)
  end

  def new
    @nutrition_record = NutritionRecord.new
    @nutrition_record.nutrition_record_lines.build
  end

  def create
    @record = NutritionRecord.new(nutrition_record_params)
    if @record.save
      redirect_to nutrition_record_path(@record.id), notice: t('notice.add_record')
    else
      render :new
    end
  end

  def show
    @nutrition_record = NutritionRecord.find(params[:id])
    @nutrition_record_lines = @nutrition_record.nutrition_record_lines
    @foods = Food.find(@nutrition_record_lines.pluck(:food_id))
  end

  def edit
    @food = Food.find(@nutrition_record.nutrition_record_lines[0].food_id)
    @foods = Food.pick_user_id(current_user.id)
  end

  def update
    if @nutrition_record.update(nutrition_record_params)
      redirect_to nutrition_record_path(@nutrition_record.id), notice: t('notice.edit_record')
    else
      render :new
    end
  end

  def destroy
    @nutrition_record.destroy
    redirect_to request.referer, notice: t('notice.destroy_record')
  end

  def my_daily
    @nutrition_records = current_user.nutrition_records.order(start_time: :desc).page(params[:page]).per(5)
  end

  private

  def pick_foods
    @foods = Food.where(user_id: current_user.id)
    @q = @foods.ransack(params[:q])
    @foods = @q.result(distinct: true)
  end

  def set_foods
    @foods = Food.all
  end

  def set_record
    @nutrition_record = NutritionRecord.find(params[:id])
  end

  def nutrition_record_params
    params.require(:nutrition_record).permit(:start_time, :user_id, nutrition_record_lines_attributes:
      [:id, :ate, :nutrition_record_id, :food_id]
    )
  end
end
