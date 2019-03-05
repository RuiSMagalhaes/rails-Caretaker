ActionMailer::Base.smtp_settings = {
  address: "smtp.caretaker.pt",
  port: 25,
  domain: 'caretaker.pt',
  user_name: ENV['EMAIL_ADDRESS'],
  password: ENV['EMAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
