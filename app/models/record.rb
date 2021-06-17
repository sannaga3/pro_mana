class Record < ApplicationRecord
  belongs_to :food
  belongs_to :user
  validates :ate, presence: { message: 'を入力してください。' }, numericality: { only_integer: true, greater_than: 0 }
end
