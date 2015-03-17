# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'coursecycle-api'
set :repo_url, 'git@github.com:coursecycle/coursecycle-api.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/coursecycle-api'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{puma.rb .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids tmp/sockets log}
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Set user name for deployment
set :user, "roger"

# Turn off sudo for deployemnt
set :use_sudo, false

# Set the Rails environment
set :rails_env, "production"

# Clones entire repository
set :deploy_via, :copy

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'puma:restart'
  after :finishing, 'nginx:restart'

end

invoke :production
