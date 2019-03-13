class Relation < ApplicationRecord
  attr_accessor :email
  belongs_to :caretaker, foreign_key: 'caretaker_id', class_name: 'User'
  belongs_to :patient, foreign_key: 'patient_id', class_name: 'User'

  # send wellcome email
  after_create :send_relation_request_email

  validates :caretaker, uniqueness: { scope: :patient }

  # permite fazer rel= Releation.create.....
  # rel.patient e rel.caretaker => User instance

  private

  def send_relation_request_email
    UserMailer.relation_request(self).deliver_now
  end
end
