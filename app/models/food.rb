class Food < ApplicationRecord
  include CommonScope
  validates :name, presence: true, length: { in: 1..50 }
  validates :protein, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit, presence: true, length: { in: 1..10 }
  belongs_to :user
  has_many :nutrition_record_lines

  scope :pick_food, lambda { |food_id|
    find_by("id = ?", food_id)
  }
  scope :nil_check, lambda {
    where.not("food_id = ?", nil).where.not("ate = ?", nil)
  }
end
