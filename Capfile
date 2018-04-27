require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/migrations'
require 'capistrano/git'

require 'capistrano/puma'
require 'capistrano/puma/workers'
# require 'capistrano/puma/jungle'
# require 'capistrano/puma/monit'
require 'capistrano/puma/nginx'

require 'capistrano/delayed-job'

require 'slackistrano'

require 'capistrano/rails/console'

# require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }