class UserMailer < ApplicationMailer
  def new_user_password_confirmation(user, raw)
    @raw = raw
    @user = user
    mail(to: @user.email, subject: 'Welcome to the VenuTrax!')
  end
end
