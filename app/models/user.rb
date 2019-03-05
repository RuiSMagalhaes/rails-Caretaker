class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_diseases
  has_many :diseases, through: :user_diseases

  has_many :notifications

  has_many :events

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
