class NutritionRecordLinesController < ApplicationController
  def destroy
    @nutrition_record_line = NutritionRecordLine.find(params[:id])
    @nutrition_record_line.destroy
    redirect_to request.referer, notice: t('notice.destroy_record')
  end
end
