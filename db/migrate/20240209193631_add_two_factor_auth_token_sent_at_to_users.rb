class AddTwoFactorAuthTokenSentAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :two_factor_auth_token_sent_at, :datetime
  end
end
