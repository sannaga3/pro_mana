class Record < ApplicationRecord
  belongs_to :food
  belongs_to :user
  validates :ate, presence: { message: 'を入力してください。' }, numericality: { only_integer: true, greater_than: 0 }

  scope :pick_start_time, -> (day) {
    where(start_time: day)
  }
  scope :pick_user_id, -> (user_id) {
    where(user_id: user_id)
  }

  def self.sum_protein(records)
    sum = 0
    records.each do |record|
      sum += (record.food.protein * record.ate)
    end
    return sum
  end
end
