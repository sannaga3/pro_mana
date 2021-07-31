class NutritionRecordLinesController < ApplicationController
  def destroy
    @nutrition_record_line = NutritionRecordLine.find(params[:id])
    @nutrition_record = NutritionRecord.find(@nutrition_record_line.nutrition_record_id)
    @nutrition_record_line.destroy
    @nutrition_record.destroy if @nutrition_record.nutrition_record_lines.count == 0
    redirect_to request.referer, notice: t('notice.destroy_record')
  end
end
