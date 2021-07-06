class NutritionRecord < ApplicationRecord
  belongs_to :user
  has_many :nutrition_record_lines

  scope :pick_start_time, lambda { |day|
    where(start_time: day)
  }
  scope :pick_user_id, lambda { |user_id|
    where(user_id: user_id)
  }

  def self.sum_protein(records)
    sum = 0
    records.each do |record|
      sum += (record.food.protein * record.ate)
    end
    sum
  end
end
