app_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
if ENV['RAILS_ENV'] == 'development'
  # Puma can serve each request in a thread from an internal thread pool.
  # The `threads` method setting takes two numbers: a minimum and maximum.
  # Any libraries that use thread pools should be configured to match
  # the maximum value specified for Puma. Default is set to 5 threads for minimum
  # and maximum; this matches the default thread size of Active Record.
  #
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  threads threads_count, threads_count

  # Specifies the `port` that Puma will listen on to receive requests; default is 3000.
  #
  port        ENV.fetch("PORT") { 3000 }

  # Specifies the `environment` that Puma will run in.
  #
  environment ENV.fetch("RAILS_ENV") { "development" }

  # Specifies the number of `workers` to boot in clustered mode.
  # Workers are forked webserver processes. If using threads and workers together
  # the concurrency of the application would be max `threads` * `workers`.
  # Workers do not work on JRuby or Windows (both of which do not support
  # processes).
  #
  # workers ENV.fetch("WEB_CONCURRENCY") { 2 }

  # Use the `preload_app!` method when specifying a `workers` number.
  # This directive tells Puma to first boot the application and load code
  # before forking the application. This takes advantage of Copy On Write
  # process behavior so workers use less memory.
  #
  # preload_app!

  # Allow puma to be restarted by `rails restart` command.
  plugin :tmp_restart
else
  # Change to match your CPU core count
  rails_env = app_dir.include?('production') ? 'production' : 'staging'
  if app_dir.include?('production')
    workers 4
  else
    workers 1
  end

  # Min and Max threads per worker
  threads 1, 6

  environment rails_env

  # Set up socket location
  bind "unix://#{app_dir}/tmp/sockets/puma.sock"

  # Logging
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{app_dir}/tmp/pids/puma.pid"
  state_path "#{app_dir}/tmp/pids/puma.state"

  activate_control_app
  on_worker_boot do
    require "active_record"
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
      ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
    end
  end

end
