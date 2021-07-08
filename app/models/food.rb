class Food < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :protein, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit, presence: true, length: { in: 1..10 }
  belongs_to :user

  scope :pick_current_user_id, lambda { |user_id|
    where(user_id: user_id)
  }
  scope :pick_food, lambda { |food_id|
    find_by(id: food_id)
  }
end
