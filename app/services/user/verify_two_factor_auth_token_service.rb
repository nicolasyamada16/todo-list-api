class User::VerifyTwoFactorAuthTokenService < ApplicationService
  steps :find_for_two_factor_auth,
        :reset_two_factor_auth_token

  def initialize(params)
    @email = params[:email]
    @two_factor_auth_token = params[:two_factor_auth_token]
  end

  def call
    process_steps

    @user
  end

  private

  def find_for_two_factor_auth
    @user = User.find_by(email: @email, two_factor_auth_token: @two_factor_auth_token, two_factor_auth_token_sent_at: User::TWO_FACTOR_AUTH_TOKEN_LIFETIME_IN_MINUTES.minutes.ago..)

    fail(I18n.t('services.user.verify_two_factor_auth_token_service.errors.invalid_token')) unless @user.present?
  end

  def reset_two_factor_auth_token
    @user.update(two_factor_auth_token: nil, two_factor_auth_token_sent_at: nil)
  end

end
