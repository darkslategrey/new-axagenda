require 'active_record'
require 'octopus'
require './lib/axlogger'

db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
ActiveRecord::Base.establish_connection db_config['jobenfance']

$LOAD_PATH.unshift './models'

Dir["models/*.rb"].each { |model| require "./#{model}" }

