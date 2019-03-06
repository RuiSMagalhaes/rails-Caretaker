class Event < ApplicationRecord
  belongs_to :user
  belongs_to :event_type

  has_many :notifications, dependent: :destroy
  validate :date_range

  def date_range
    if end_time < start_time
      errors.add(:end_time, ' can not be before Start time.')
    end
  end
end
