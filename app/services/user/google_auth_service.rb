class User::GoogleAuthService < ApplicationService
  steps :verify_oauth2_code,
        :search_user_info,
        :find_or_create_user

  def initialize(params)
    @oauth2_code = params[:oauth2_code]
    @platform = params[:platform]
  end

  def call
    process_steps

    @user
  end

  private

  def verify_oauth2_code
    client = Google::ExchangeCodeClient.new
    @response = client.exchange_for_token(@oauth2_code, @platform)

    fail(I18n.t('services.google_auth_service.errors.invalid_token')) unless @response.success?
  end

  def search_user_info
    client = Google::UserInfoClient.new
    @response = client.get_info(@response.result[:access_token])

    fail(I18n.t('services.google_auth_service.errors.invalid_token')) unless @response.success?
  end

  def find_or_create_user
    @user = User.create_with(user_params).find_or_create_by(email: @response.result[:email])
  end

  def user_params
    {
      name: @response.result[:name],
      password: Devise.friendly_token[0, 20]
      # remote_avatar_url: @response.result[:picture],
    }
  end

end
