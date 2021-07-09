class Reply < ApplicationRecord
  include CommonScope
  belongs_to :contact
  validates :comment, presence: true, length: { in: 1..1000 }
end
