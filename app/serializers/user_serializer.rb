class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token

  def token
    scope[:token] if scope.present?
  end

end
