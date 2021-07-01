class Reply < ApplicationRecord
  belongs_to :contact
  validates :comment, presence: true, length: { in: 1..1000 }
end
