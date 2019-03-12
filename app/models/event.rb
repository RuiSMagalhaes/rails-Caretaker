class Event < ApplicationRecord
  attr_accessor :notifications

  after_create :job_event_to_notification

  belongs_to :user
  belongs_to :event_type

  has_many :notifications, dependent: :destroy
  validate :date_range

  private

  def date_range
    errors.add(:end_time, ' can not be before Start time.') if end_time < start_time
  end

  def job_event_to_notification
    # Call a Job for the user of the event (event.user) to notify (type:DO) him on time = event.start_time (if event.done == false => see this only in the job)
    NotifyEventUserDoJob.set(wait_until: self.start_time).perform_later(self.id)
    # If notify_before is true, the user of the event has to be notified as well as all his caretakers
    if self.notify_before
      # TODO: Call a Job to create a notification to the user and to his caretakers some time (defined by event.minutes) before the event.start_time
      # if a user do not populate the minutes field, it's 15min as a default. this notification will pop up 15 min before the start time of the event
      self.minutes = 15 if self.minutes.nil?
      if self.start_time - self.minutes.minutes < Time.now
        NotifyCaretakerAndEventUserBeforeJob.perform_later(self.id)
      else
      # call the Job the the caretakers of the user and for the user of the event
        NotifyCaretakerAndEventUserBeforeJob.set(wait_until: self.start_time - self.minutes.minutes).perform_later(self.id)
      end
    end
    # If notify_missed is true, the user of the event has to be notified as well as all his caretakers
    # TODO: Call a Job to create notifications for the user of the event his caretakers 15 minutes after the event.start_time (if done == false => check this on the Job only)
    NotifyCaretakerAndEventUserMissedJob.set(wait_until: self.start_time + 15.minutes).perform_later(self.id) if self.notify_missed
    # if notify_done is true, all the caretakers of the user of the event need to be notified when the user of the event press the button "Done"
    # this logic is on the notification controller
  end
end
