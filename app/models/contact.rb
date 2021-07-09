class Contact < ApplicationRecord
  include CommonScope
  belongs_to :user
  validates :title, presence: true, length: { in: 1..100 }
  validates :content, presence: true, length: { in: 1..1000 }
  has_many :replies, dependent: :destroy
end
