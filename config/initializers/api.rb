APPCONFIG = YAML.load_file("#{Rails.root}/config/api.yml")[Rails.env]

require 'api/errors'