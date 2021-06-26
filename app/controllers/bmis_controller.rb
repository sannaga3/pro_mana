class BmisController < ApplicationController
  before_action :set_bmi, only: %i[ edit update destroy ]

  def index
    @bmis = Bmi.all
  end

  def new
    @bmi = Bmi.new
  end

  def create
    @user = current_user
    weight = @user.weight
    height = (@user.height / 100.0).to_f
    @bmi_calculate = weight/(height ** 2).to_f
    @bmi_calculate = @bmi_calculate.round(1)
    # @bmi_calculate = (weight / height ** 2).round(1)
    # binding.irb
    @bmi = Bmi.new(bmi_params)
    if @bmi.save
      redirect_to bmis_path, notice: "aaaaaa"
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
    params.require(:bmi).permit(:record_on, :status, :user_id).merge(status: @bmi_calculate)
  end
end
