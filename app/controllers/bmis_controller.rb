class BmisController < ApplicationController
  before_action :set_bmi, only: [:edit, :update, :destroy ]

  def index
    @bmis = Bmi.where(user_id: current_user.id).order(record_on: :desc)
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
    Bmi.calculate_bmi
    @user = current_user
    weight = @user.weight
    height = (@user.height / 100.0).to_f
    @bmi_calculate = weight/(height ** 2).to_f
    @bmi_calculate = @bmi_calculate.round(1)
    @bmi = Bmi.new(bmi_params)
    @bmis = Bmi.all.where(user_id: current_user.id)
    @built_bmi = @bmis.find_by(record_on: @bmi.record_on)
    if @built_bmi
      flash.now[:notice] = '同じ日付のBMIが既に登録されています'
      render :new and return
    end
    if @bmi.save
      redirect_to bmis_path, notice: "BMI登録"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @record_on = Bmi.new(bmi_params)
    weight = @bmi.weight
    height = (@bmi.height / 100.0).to_f
    @bmi_calculate = weight/(height ** 2).to_f
    @bmi_calculate = @bmi_calculate.round(1)
    @bmi.status = @bmi_calculate
    @bmis = Bmi.where(user_id: current_user.id)
    @built_bmi = @bmis.find_by(record_on: @record_on.record_on)
    if @built_bmi != nil
      flash.now[:notice] = '同じ日付のBMIが既に登録されています'
      render :edit
    else
      if @bmi.update(bmi_params)
        redirect_to bmis_path, notice: "BMI編集"
      else
        render :edit
      end
    end
  end

  def destroy
    @bmi.destroy
    redirect_to bmis_path, notice: "BMIを削除しました"
  end

  private

  def set_bmi
    @bmi = Bmi.find(params[:id])
  end

  def calculate_bmi
    #リファクタリング用
  end

  def bmi_params
    params.require(:bmi).permit(:height, :weight, :record_on, :status, :user_id).merge(status: @bmi_calculate)
  end
end
