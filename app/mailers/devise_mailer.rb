class DeviseMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/javascript/images/login/VenuTRAX-WH-2.png")
  end

end