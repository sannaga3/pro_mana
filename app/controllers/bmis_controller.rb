class BmisController < ApplicationController
  def create
    @bmi = Bmi.new(Bmi_params)
    if @bmi.save
      redirect_to user_path(@bmi.user_id), notice: "aaaaaa"
    else
      render :new
    end
  end
  
end
