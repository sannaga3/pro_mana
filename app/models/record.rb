class Record < ApplicationRecord
  belongs_to :food
  belongs_to :user
  validates :ate, presence: { message: 'を入力してください。' }
end
