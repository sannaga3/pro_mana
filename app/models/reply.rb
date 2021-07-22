class Reply < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  validates :comment, presence: true, length: { in: 1..1000 }
end
