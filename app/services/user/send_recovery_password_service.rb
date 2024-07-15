class User::SendRecoveryPasswordService < ApplicationService
  steps :find_user,
        :generate_temporary_password,
        :send_recovery_password

  TEMPORARY_PASSWORD_LENGTH = 6

  def initialize(params)
    @email = params[:email]
  end

  def call
    process_steps
  end

  private

  def find_user
    @user = User.find_for_database_authentication(email: @email)
    fail([I18n.t('services.session_service.errors.user_not_found')]) if @user.blank?
  end

  def generate_temporary_password
    temp_pass = Devise.friendly_token(TEMPORARY_PASSWORD_LENGTH).downcase

    @user.update(password: temp_pass, temporary_password: temp_pass, reset_password_sent_at: DateTime.current)
  end

  def send_recovery_password
    PasswordMailer.send_new_password_mail(@user).deliver_later
  end

end
