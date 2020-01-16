# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :application, '[APP-NAME-HERE]'
set :repo_url, 'git@bitbucket.org:[YOUR-URL-HERE].git' # Edit this to match your repository, this can be any other git repo.
set :branch, :master
set :deploy_to, '/home/[FILE-PATH-ON-SERVER]'
set :pty, true
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/assets}
set :keep_releases, 5
set :linked_files, %w{config/application.yml}
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.4.1' # Edit this if you are using MRI Ruby

# set :rvm_custom_path, '/usr/share/rvm'
set :user, 'deploy'
set :ssh_options,     { forward_agent: false, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

set :linked_dirs, fetch(:linked_dirs, []).concat(%w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system})

set :log_files, %w{puma.access.log puma.error.log production.log}
set :linked_files, fetch(:linked_files, []).concat(fetch(:log_files).map{|log_file| "log/#{log_file}"})

set :keep_releases, 8

set :puma_service, 'app-puma.service'

namespace :deploy do
  namespace :check do
    task :create_log_files do
      on roles(:app) do
        fetch(:log_files).each {|log_file| execute :touch, "#{shared_path}/log/#{log_file}"}
      end
    end
  end
end

namespace :puma do
    task :start do
      on roles(:app) do
        sudo :systemctl, :start, fetch(:puma_service)
      end
    end
  
    task :stop do
      on roles(:app) do
        sudo :systemctl, :stop, fetch(:puma_service)
      end
    end
  
    task :restart do
      on roles(:app) do
        sudo :systemctl, :restart, fetch(:puma_service)
      end
    end
  
    task :reload do
      on roles(:app) do
        sudo :systemctl, 'reload-or-restart', fetch(:puma_service)
      end
    end
  end

  # HOOKS
before 'deploy:check:linked_files', 'deploy:check:create_log_files'
after 'deploy:log_revision', 'puma:reload'
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_error.log"
# set :puma_error_log, "#{shared_path}/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 8]
# set :puma_workers, 0
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true
# set :puma_preload_app, false

