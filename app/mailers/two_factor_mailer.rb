class TwoFactorMailer < ApplicationMailer
  def send_two_factor_auth_token_mail(user, token)
    @user = user
    @layout_subject = I18n.t('mail.two_factor.subject')
    @token = token

    mail(to: I18n.t('mail.mail_to', name: @user.name, email: @user.email), subject: @layout_subject)
  end

end
