class Food < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :protain, presence: true
  validates :quantity, presence: true
  validates :unit, presence: true
end
