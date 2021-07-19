class Reply < ApplicationRecord
  include CommonScope
  belongs_to :contact
  belongs_to :user
  validates :comment, presence: true, length: { in: 1..1000 }

  scope :pick_contact_id, lambda { |contact_id|
    where('contact_id = ?', contact_id)
  }
end
