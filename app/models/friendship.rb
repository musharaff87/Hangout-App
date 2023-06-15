class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    scope :accepted, -> { where(status: 'accepted') }
    scope :pending, -> { where(status: 'pending') }
  
    # enum status: {pending: 0, accepted: 1  }

  end
  