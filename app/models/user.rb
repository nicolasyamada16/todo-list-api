class User < ApplicationRecord
  include TokenAuthenticatable
  include RailsAdmin::User

  VALID_PERIOD_OF_TEMPORARY_PASSWORD = 1 # days
  TWO_FACTOR_AUTH_TOKEN_LIFETIME_IN_MINUTES = 5

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

end
