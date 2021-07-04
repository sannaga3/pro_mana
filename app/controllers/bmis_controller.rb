class BmisController < ApplicationController
  before_action :set_bmi, only: %i[edit update destroy]

  def index
    @bmis = Bmi.pick_user_id(current_user.id).order_record_on
    if @bmis.count > 2
      @chart_elements = []
      @bmis.each do |bmi|
        @chart_elements << [bmi.record_on, bmi.status]
      end
    end
  end

  def new
    @bmi = Bmi.new
  end

  def create
    @bmi = current_user.bmis.new(bmi_params)
    if @bmi.save
      redirect_to bmis_path, notice: 'BMI登録'
    else
      render :new
    end
  end

  def edit; end

  def update
    @bmi = current_user.bmis.find(params[:id])
    if @bmi.update(bmi_params)
      redirect_to bmis_path, notice: 'BMI編集しました'
    else
      render :edit
    end
  end

  def destroy
    @bmi.destroy
    redirect_to bmis_path, notice: 'BMIを削除しました'
  end

  private

  def set_bmi
    @bmi = Bmi.find(params[:id])
  end

  def bmi_params
    params.require(:bmi).permit(:height, :weight, :record_on, :status)
  end
end
