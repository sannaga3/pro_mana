class BmisController < ApplicationController
  before_action :set_bmi, only: %i[ edit update destroy ]

  def index
    @bmis = Bmi.all
  end

  def new
    @bmi = Bmi.new
  end

  def create
    @bmi = Bmi.new(calculation_bmi)
    if @bmi.save
      redirect_to user_bmis_path(@user), notice: "aaaaaa"
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @bmi.update(bmi_params)
      redirect_to bmi_path, notice: t('notice.edit_food')
    else
      render :new
    end
  end

  def destroy
    @bmi.destroy
    redirect_to foods_path, notice: t('notice.destroy_food')
  end

  private

  def set_bmi
    @bmi = Bmi.find(params[:id])
  end

  def bmi_params
    params.require(:bmi).permit(:height, :weight, :status, :record_on, :user_id)
  end

  def calculation_bmi
    bmi_params.merge(@bmi.set_calculation_bmi)
  end
end
