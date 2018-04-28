set :repo_url, 'git@github.com:pierreyfl/ormdo.git'

set :use_sudo, true
set :migration_role, 'db'
set :conditionally_migrate, false

set :pty, false

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{public/system tmp/pids tmp/sockets log}

set :keep_releases, 2

set :rvm_type, :user
set :rvm_ruby_version, '2.2.2@lolyapp'
set :rvm_autolibs_flag, "read-only"

set :delayed_job_roles, [:app]

set :slack_run_starting,     -> { false }
set :slack_run_finished,     -> { true }
set :slack_run_failed,       -> { false }
set :slack_via_slackbot, true
set :slack_team, "agivis"
set :slack_token, ENV['SLACK_TOKEN']
set :slack_channel, '#loly'
set :slack_msg_finished, -> { "#{ENV['SLACK_USER'] || ENV['USER'] || ENV['USERNAME']} finalizou deploy da API em #{fetch :rails_env, 'production'}" }
set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy
set :pty, true

set :ssh_options, {
    forward_agent: true,
    auth_methods: ["publickey"],
    keys: ['/home/ferhan/.ssh/.ssh/id_rsa.pub']
}
after 'deploy:updated', 'deploy:migrate'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:stop'
      invoke 'puma:start'
      invoke 'delayed_job:restart'
    end
  end

  after :publishing, :restart

  task :migrate do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  task :create do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end

  task :paperclip_refresh do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "paperclip:refresh:missing_styles"
        end
      end
    end
  end

  namespace :assets do
    Rake::Task["deploy:assets:precompile"].clear_actions
    task :precompile do
      on roles(fetch(:assets_roles)) do
        rsync_host = host.to_s
        rsync_user = host.user.to_s
        run_locally do
          with rails_env: fetch(:stage) do
            execute :bundle, "exec rake assets:precompile"
          end

          execute "rsync -av --delete ./public/assets/ #{rsync_user}@#{rsync_host}:#{release_path}/public/assets/"

          with rails_env: fetch(:stage) do
            execute :bundle, "exec rake assets:clean"
          end
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :log do
  desc "tail rails logs"
  task :rails do
    on roles(:app) do
      execute "tail -f #{current_path}/log/#{fetch(:rails_env)}.log"
    end
  end

end


# namespace :sidekiq do
#   desc "tail rails logs"
#   task :start do
#     on roles(:app) do
#       execute "tail -f #{current_path}/log/#{fetch(:rails_env)}.log"
#     end
#   end
# end