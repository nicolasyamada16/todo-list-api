class User::TwoFactorAuthService < ApplicationService
  TWO_FACTOR_AUTH_TOKEN_LENGTH = 4

  steps :verify_user_credentials,
        :generate_two_factor_auth_token,
        :update_two_factor_auth_token,
        :send_two_factor_auth_token

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def call
    process_steps

    @user
  end

  private

  def verify_user_credentials
    session_service = User::CreateSessionService.call(email: @email, password: @password)

    fail(session_service.errors) unless session_service.success?

    @user = session_service.result
  end

  def generate_two_factor_auth_token
    @token = (1..TWO_FACTOR_AUTH_TOKEN_LENGTH).map { |_| SecureRandom.random_number(10) }.join('')
  end

  def update_two_factor_auth_token
    @user.update(two_factor_auth_token: @token, two_factor_auth_token_sent_at: Time.now.utc)
  end

  def send_two_factor_auth_token
    TwoFactorMailer.send_two_factor_auth_token_mail(@user, @token).deliver_now
  end

end
