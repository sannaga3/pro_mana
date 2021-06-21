class Food < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :protein, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit, presence: true, length: { in: 1..10 }
  belongs_to :user
  has_many :records

  # scope :find_food_id, -> (food_id) {
  #   find(id: food_id)
  # }
end
