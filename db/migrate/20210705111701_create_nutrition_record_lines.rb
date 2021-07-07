class CreateNutritionRecordLines < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrition_record_lines do |t|
      t.integer :ate
      t.references :nutrition_record, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
