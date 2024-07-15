Sentry.init do |config|
  return if Rails.env.development?

  config.dsn = Rails.application.credentials.dig(Rails.env.to_sym, :sentry_access_token).to_s
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  # config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end