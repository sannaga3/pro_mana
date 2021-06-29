class Friendship < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  scope :find_current_user, lambda { |current_user_id|
    where(follower_id: current_user_id)
  }
end
