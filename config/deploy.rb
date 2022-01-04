lock "~> 3.16.0"

# replace obvious parts
server 'ec2-54-151-254-250.ap-southeast-1.compute.amazonaws.com', port: 22, roles: [:web, :app, :db], primary: true
set :application, "template-project"
set :repo_url, "git@github.com:wellcodeglobal/template_project.git"
set :branch, "main"

set :rbenv_ruby, '3.0.0'
set :rbenv_path, '/home/ubuntu/.rbenv'
set :rbenv_type, :system
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :default_env, {
  PATH: '$HOME/.nvm/versions/node/v14.16.0/bin/:$PATH',  
  NODE_ENVIRONMENT: 'production'
}

set :user, 'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :bundle_jobs,     4

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/template-project.cer) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads"

namespace :deploy do
  after  :starting, 'envvars:load'
end

# https://webdevchallenges.com/how-to-deploy-a-rails-6-application-with-capistrano

# set :bundle_roles, :all                                         # this is default
# set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
# set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
# set :bundle_gemfile, -> { release_path.join('MyGemfile') }      # default: nil
# set :bundle_path, -> { shared_path.join('bundle') }             # this is default. set it to nil for skipping the --path flag.
# set :bundle_without, %w{development test}.join(' ')             # this is default
# set :bundle_flags, '--deployment --quiet'                       # this is default
# set :bundle_env_variables, {}                                   # this is default
# set :bundle_clean_options, ""                                   # this is default. Use "--dry-run" if you just want to know what gems would be deleted, without actually deleting them
# set :bundle_check_before_install, true

# append :linked_files, "config/database.yml", "config/secrets.yml"

# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
#before "deploy:assets:precompile", "deploy:yarn_install"
