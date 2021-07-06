class NutritionRecord < ApplicationRecord
  belongs_to :user
  has_many :nutrition_record_lines, dependent: :destroy
  accepts_nested_attributes_for :nutrition_record_lines, allow_destroy: true, reject_if: :all_blank

  scope :pick_start_time, lambda { |day|
    where(start_time: day)
  }
  scope :pick_user_id, lambda { |user_id|
    where(user_id: user_id)
  }

  def self.sum_protein(records)
    sum = 0
    records.each do |record|
      sum += (Food.find_by(id: record.nutrition_record_lines[0].food_id).protein * record.nutrition_record_lines[0].ate)
    end
    sum
  end
end
