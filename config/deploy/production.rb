set :application, 'lolyapp'
set :deploy_to, '/var/www/lolyapp/api'

server '54.94.247.76',
       user: 'ubuntu',
       roles: %w{web app puma_nginx},
       ssh_options: {
           user: 'ubuntu',
           forward_agent: true,
           auth_methods: %w(publickey)
       }

set :user, 'ubuntu'

set :branch, :master
set :rails_env, :production

set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
set :puma_init_active_record, true
set :nginx_server_name, 'loly.prod.agivis.com.br'