class Bmi < ApplicationRecord
  belongs_to :user
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true
  validates :record_on, uniqueness: { scope: :user }
  before_validation :set_bmi

  scope :pick_user_id, lambda { |user_id|
    where(user_id: user_id)
  }

  def set_bmi
    self.status = (weight/((height/100.0) ** 2).to_f).round(1)
  end
end
