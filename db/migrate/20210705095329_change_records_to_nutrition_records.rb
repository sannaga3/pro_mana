class ChangeRecordsToNutritionRecords < ActiveRecord::Migration[5.2]
  def change
    rename_table :records, :nutrition_records
  end
end
