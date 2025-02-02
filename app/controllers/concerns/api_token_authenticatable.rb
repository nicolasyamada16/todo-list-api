# Esse arquivo e padrao do time WEB, portanto foi apenas trazido de outros lugares

module ApiTokenAuthenticatable
  extend ActiveSupport::Concern
  # You can use any model, like Admin or Driver, just sent headers like above pattern
  # HTTP_#{model_name}_EMAIL and HTTP_#{model_name}_TOKEN

  def authenticate_user_from_token!
    authenticate_from_token! User
  end

  def build_headers_if_needed!
    current_user.refresh_token.map { |key, value| response.headers[key.to_s] = value.to_s } if current_user.present?
  end

  def build_headers_token(user)
    return unless user&.persisted?

    authenticate = user.refresh_token

    response.headers['HTTP_USER_EMAIL'] = authenticate[:email]
    response.headers['HTTP_USER_TOKEN'] = authenticate[:token]

    authenticate
  end

  def current_user
    @user
  end

  private

  def authenticate_from_token!(model)
    user, request_token = find_authenticable_by_headers(model)

    if user.present? && user.token_match?(request_token)
      sign_in user, store: false
      @user ||= user
    else
      render_unauthorized
    end
  end

  def find_authenticable_by_headers(model)
    request_email = request.headers["HTTP_#{header_name(model)}_EMAIL"].presence
    request_token = request.headers["HTTP_#{header_name(model)}_TOKEN"].presence

    user = request_email && model.find_by(email: request_email)
    [user, request_token]
  end

  def header_name(model)
    model.name.upcase
  end
end
