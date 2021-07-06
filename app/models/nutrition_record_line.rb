class NutritionRecordLine < ApplicationRecord
  belongs_to :nutrition_record
  has_one :food
  validates :ate, presence: { message: 'を入力してください。' }, numericality: { only_integer: true, greater_than: 0 }
end