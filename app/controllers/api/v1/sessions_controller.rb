class Api::V1::SessionsController < ApplicationController
  def create
    response_handler(User::CreateSessionService.call(session_params))
  end

  def google_auth
    response_handler(User::GoogleAuthService.call(oauth2_params))
  end

  def two_factor_sign_in
    two_factor_auth_service = User::TwoFactorAuthService.call(session_params)

    return render_no_content if two_factor_auth_service.success?

    render_unprocessable_entity(two_factor_auth_service.errors)
  end

  def verify_two_factor_auth_token
    response_handler(User::VerifyTwoFactorAuthTokenService.call(verify_two_factor_auth_token_params))
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def oauth2_params
    params.permit(:oauth2_code, :platform, user_info: {})
  end

  def verify_two_factor_auth_token_params
    params.permit(:two_factor_auth_token, :email)
  end

  def response_handler(service)
    if service.success?
      authenticate = build_headers_token(service.result)
      render_success(serialize_resource(service.result, UserSerializer, scope: authenticate))
    else
      render_unprocessable_entity(service.errors)
    end
  end

end
