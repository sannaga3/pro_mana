class Food < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :protein, presence: true
  validates :quantity, presence: true
  validates :unit, presence: true, length: { in: 1..10 }
  belongs_to :user
  has_many :records
end
