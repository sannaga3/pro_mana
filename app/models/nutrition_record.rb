class NutritionRecord < ApplicationRecord
  include CommonScope
  belongs_to :user
  has_many :nutrition_record_lines, dependent: :destroy
  accepts_nested_attributes_for :nutrition_record_lines, allow_destroy: true, reject_if: :all_blank
  validates :start_time, presence: true
  validates :start_time,  uniqueness: { scope: :user }

  scope :pick_start_time, lambda { |day|
    where(start_time: day)
  }

  def self.sum_protein(nutrition_records)
    sum = 0
    nutrition_records.each do |nutrition_record|
      nutrition_record.nutrition_record_lines.each do |line|
        sum += (Food.find_by(id: line.food_id).protein * line.ate) if (line.food_id != nil) && (line.ate != nil)
      end
    end
    sum
  end
end
