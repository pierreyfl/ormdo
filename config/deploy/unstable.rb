set :application, 'loly'
set :deploy_to, '/var/www/apps/loly'

server '54.210.15.45',
       user: 'ubuntu',
       roles: %w{web app puma_nginx},
       ssh_options: {
           user: 'ubuntu',
           forward_agent: true,
           auth_methods: %w(publickey)
       }

set :user, 'ubuntu'

set :branch, :unstable
set :rails_env, :unstable

set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
set :puma_init_active_record, true
set :nginx_server_name, 'loly.unstable.agivis.com.br'