class Bmi < ApplicationRecord
  belongs_to :user
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true

  scope :pick_user_id, lambda { |user_id|
    where(user_id: user_id)
  }
end
