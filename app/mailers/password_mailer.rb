class PasswordMailer < ApplicationMailer
  def send_new_password_mail(user)
    @user = user
    @layout_subject = I18n.t('mail.recovery_password.subject')

    mail(to: I18n.t('mail.mail_to', name: @user.name, email: @user.email), subject: @layout_subject)
  end

end
