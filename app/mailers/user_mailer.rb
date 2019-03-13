class UserMailer < ApplicationMailer
  include Devise::Mailers::Helpers

  def confirmation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end

  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'CARETAKER - Welcome to Caretaker')
  end

  def relation_request(relation)
    @sender_user = User.find(relation.sender_id)
    if relation.caretaker == @sender_user
      @request_user = relation.patient
      @role = 'patient'
    else
      @request_user = relation.caretaker
      @role = 'caretaker'
    end
    mail(to: @request_user.email, subject: "CARETAKER - New request to be a #{@role}")
  end
end
