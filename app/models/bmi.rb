class Bmi < ApplicationRecord
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true
  belongs_to :user
end
