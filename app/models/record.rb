class Record < ApplicationRecord
  belongs_to :food
  belongs_to :user
  validates :ate, presence: { message: 'を入力してください。' }, numericality: { only_integer: true, greater_than: 0 }

  scope :pick_record_on, -> (day) {
    where(record_on: day)
  }
  scope :pick_user_id, -> (user_id) {
    where(user_id: user_id)
  }
end
