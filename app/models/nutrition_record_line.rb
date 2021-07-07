class NutritionRecordLine < ApplicationRecord
  belongs_to :nutrition_record
  has_one :food
  validates :ate, presence: { message: 'を入力してください。' }, numericality: { only_integer: true, greater_than: 0 }

  # def self.sum_protein(nutrition_record)
  #   sum = 0
  #   nutrition_record.nutrition_record_lines.each do |line|
  #     sum += (Food.find_by(id: line.food_id).protein * line.ate)
  #   end
  #   sum
  # end
end