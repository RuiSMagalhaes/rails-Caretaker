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

    mail(to: @user.email, subject: 'Welcome to Caretaker')
  end
end
