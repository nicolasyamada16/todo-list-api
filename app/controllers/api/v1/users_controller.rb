class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user_from_token!, only: [:show, :update, :update_password]

  def show
    render_success(current_user)
  end

  def create
    user = User.new(user_params)

    if user.save
      authenticate = build_headers_token(user)
      return render_created(serialize_resource(user, UserSerializer, scope: authenticate))
    end

    render_unprocessable_entity(user.errors.full_messages)
  end

  def update
    current_user.assign_attributes(user_params)

    return render_success(current_user) if current_user.save

    render_unprocessable_entity(current_user.errors.full_messages)
  end

  def update_password
    service = ::User::UpdatePasswordService.call({ user: current_user, password_params: })

    return render_unprocessable_entity(service.errors) unless service.success?

    render_success(serialize_resource(service.result, UserSerializer))
  end

  def recovery_password
    ::User::SendRecoveryPasswordService.call(recovery_password_params)
    render_success
  end

  private

  def recovery_password_params
    params.permit(:email)
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def password_params
    params.permit(:password, :current_password, :password_confirmation)
  end

end
