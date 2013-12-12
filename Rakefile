require 'rubygems'
require 'bundler'
require 'rake'
require 'active_record'
require 'sinatra/activerecord/rake'
# require './app'
require 'octopus'

Bundler.setup

db_config = YAML.load_file('./config/databases.yml')
ActiveRecord::Base.establish_connection db_config['axagenda']



Dir["tasks/*.rake"].sort.each { |ext| load ext }
