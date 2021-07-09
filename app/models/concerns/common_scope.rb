require 'active_support'

module CommonScope
  extend ActiveSupport::Concern
  included do
    scope :pick_current_user_id, lambda { |user_id|
      where("user_id = ?", user_id)
    }
    scope :order_record_on, -> { order(record_on: :desc) }
    scope :order_id, -> { order(id: :desc) }
  end
end