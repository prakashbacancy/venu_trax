class DeviseMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/javascript/images/login/VenuTRAX-WH-2s.png")
    super
  end
end