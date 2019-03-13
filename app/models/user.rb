class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # send wellcome email
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  has_many :user_diseases
  has_many :diseases, through: :user_diseases

  has_many :events

  has_many :notifications
  has_many :events_notifications, through: :events, source: :notifications


  has_many :patient_relationships, foreign_key: :caretaker_id, class_name: 'Relation'
  has_many :patients, through: :patient_relationships, source: :patient

  has_many :caretaker_relationships, foreign_key: :patient_id, class_name: 'Relation'
  has_many :caretakers, through: :caretaker_relationships, source: :caretaker

  validates :first_name, :last_name, :email, presence: true

  def pending_caretaker_requests
    patient_relationships.where(state: false)
  end

  def pending_patient_requests
    caretaker_relationships.where(state: false)
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
