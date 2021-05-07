class UserMailer < ApplicationMailer
  def new_user_password_confirmation(user, raw)
    @raw = raw
    @user = user
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/javascript/images/login/VenuTRAX-WH-2s.png")
    mail(to: @user.email, subject: 'Welcome to the VenuTrax!')
  end
end
