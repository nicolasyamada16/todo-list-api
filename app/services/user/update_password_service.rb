class User::UpdatePasswordService < ApplicationService
  steps :validate_password,
        :update_password

  def initialize(params)
    @user = params[:user]
    @password_params = params[:password_params]
  end

  def call
    process_steps

    @user
  end

  private

  def validate_password
    valid_password = Devise.secure_compare(@password_params[:password],
                                           @password_params[:password_confirmation]) && @user.valid_password?(@password_params[:current_password])

    fail(I18n.t('services.session_service.errors.invalid_password')) unless valid_password
  end

  def update_password
    @user.update(password: @password_params[:password])
  end

end
