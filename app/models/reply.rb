class Reply < ApplicationRecord
  include CommonScope
  belongs_to :contact
  validates :comment, presence: true, length: { in: 1..1000 }
  validates :replier_id, presence: true

  scope :pick_contact_id, lambda { |contact_id|
    where("contact_id = ?", contact_id)
  }
end
