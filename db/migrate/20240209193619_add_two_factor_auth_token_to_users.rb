class AddTwoFactorAuthTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :two_factor_auth_token, :string
  end
end
