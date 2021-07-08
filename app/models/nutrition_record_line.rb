class NutritionRecordLine < ApplicationRecord
  belongs_to :nutrition_record
  has_one :food
  validates :ate, presence: true, numericality: { only_integer: true, greater_than: 0 }, on: :create
  validates :food_id, presence: true, on: :create
end