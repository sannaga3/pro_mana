class Bmi < ApplicationRecord
  include CommonScope
  belongs_to :user
  validates :height, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }
  validates :record_on, uniqueness: { scope: :user }
  before_validation :set_bmi

  scope :order_record_on, -> { order(record_on: :desc)}

  def set_bmi
    self.status = (weight/((height/100.0) ** 2).to_f).round(1) if height != nil && weight != nil
  end
end
