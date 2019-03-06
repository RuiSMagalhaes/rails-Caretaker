class Event < ApplicationRecord
  belongs_to :user
  belongs_to :event_type

  has_many :notifications, dependent: :destroy
end
