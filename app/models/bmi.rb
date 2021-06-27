class Bmi < ApplicationRecord
  belongs_to :user
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true
end
