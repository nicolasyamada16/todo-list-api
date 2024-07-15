require 'mina/bundler'
require 'mina/deploy'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :repository, '<GIT_DO_PROJETO>'

set :identity_file, ENV['KEY'] || ENV['IDENTIFY_FILE']
set :environment,   ENV['ENV']

set :application_name, 'api_template'
set :user, fetch(:application_name)
set :ruby_version, '3.3.0'
set :rvm_use_path, '/usr/local/rvm/scripts/rvm'
set :gemset, fetch(:user)

if fetch(:environment) == 'staging'
  set :branch,    'develop'
  set :rails_env, 'staging'
  set :domain,    'sif.jera.com.br'
  set :deploy_to, "/var/www/#{fetch(:user)}/staging"
elsif fetch(:environment) == 'production'
  set :branch,    'main'
  set :rails_env, 'production'
  set :domain,    'valhalla.jera.com.br'
  set :deploy_to, "/var/www/#{fetch(:user)}/production"
end

set :pid_folder, "#{fetch(:deploy_to)}/current/tmp/pids"
set :sidekiq_pid, "#{fetch(:pid_folder)}/sidekiq.pid"
set :puma_pid, "#{fetch(:pid_folder)}/puma.pid"

set :puma_service, "puma_#{fetch(:application_name)}.service"
set :sidekiq_service, "sidekiq_#{fetch(:application_name)}.service"

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'public/system', 'tmp/pids', 'tmp/sockets')

set :shared_files, fetch(:shared_files, []).push('public/uploads', 'config/database.yml', '.ruby-gemset', '.ruby-version')

task :remote_environment do
  ruby_version = File.read('.ruby-version').strip
  ruby_gemset = File.read('.ruby-gemset').strip

  gemset = "#{ruby_version}@#{ruby_gemset}"
  raise "Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?" if ruby_version.empty?

  invoke :'rvm:use', gemset
end

task :restart => :remote_environment do
  command %[sudo systemctl restart #{fetch(:puma_service)}]
  command %[sudo systemctl restart #{fetch(:sidekiq_service)}]
end

task :status => :remote_environment do
  command %{ echo '========== Puma status ==========\n' }
  command %[sudo systemctl --no-pager status #{fetch(:puma_service)}]
  command %{ echo '\n========== Sidekiq status ==========\n' }
  command %[sudo systemctl --no-pager status #{fetch(:sidekiq_service)}]
end

task log: :remote_environment do
  unless fetch(:environment)
    abort 'You need to pass the identify file and environment, ex. mina log ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem'
  end
  command %[tail -f -n 200 "#{fetch(:deploy_to)}/shared/log/#{fetch(:environment)}.log"]
end

task sidekiq_log: :environment do
  # não ta funfando, cobra o beto pra fazer arrumar isso
end

task :setup do
  in_path(fetch(:shared_path)) do
    command %[mkdir -p "#{fetch(:deploy_to)}/shared/log"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

    command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/pids"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp/sockets"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/sockets"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/system"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/system"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/uploads"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/uploads"]

    command %[echo "#{fetch(:ruby_version)}" > "#{fetch(:deploy_to)}/shared/.ruby-version"]

    command %[echo "#{fetch(:gemset)}" > "#{fetch(:deploy_to)}/shared/.ruby-gemset"]

    command %[touch "#{fetch(:deploy_to)}/shared/log/sidekiq.log"]
  end
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command %[echo "ENV ---> #{fetch(:environment)}"]
    command %[echo "DEPLOY_TO ---> #{fetch(:deploy_to)}"]
    command %[echo "SHARED PATH ---> #{fetch(:shared_path)}"]
    command %[bundle install --without development test]
    invoke :'rails:db_migrate'
    command %[yarn install]
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :restart
      invoke :status
    end
  end
end
