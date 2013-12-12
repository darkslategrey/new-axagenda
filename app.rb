require 'rubygems'
require 'sinatra'
require 'sinatra/assetpack'
require 'haml'
require 'json'
require 'active_record'
require 'octopus'


$LOAD_PATH.unshift './models'

Dir["models/*.rb"].each { |model| require "./#{model}" }

db_config = YAML.load_file('./config/databases.yml')
ActiveRecord::Base.establish_connection db_config['jobenfance']

# Helpers
require './lib/render_partial'
require './lib/axlogger'

class AxAgenda < Sinatra::Base
  # Set Sinatra variables
  set :root, File.dirname(__FILE__)
  set :app_file, __FILE__

  set :views, 'views'
  set :public_folder, 'public'
  set :haml, {:format => :html5} # default Haml format is :xhtml

  register Sinatra::AssetPack

  configure do
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  assets do
    serve '/js',        :from => 'public/js'
    serve '/css',       :from => 'public/css'
    serve '/image',     :from => 'public/js/feyaSoft/calendar/image'
    serve '/resources', :from => 'public/js/extjs/resources'

    js :application, '/js/axagenda.js', [ 'js/extjs/ext-all.js',
                                          'js/ext_notification.js',
                                          'js/application.js',
                                          'js/feyaSoft/calendar/view/BasicView.js',
                                          '/js/feyaSoft/calendar/**/*.js' ]


    css :application, '/css/axagenda.css', [ '/css/main.css',
                                             '/js/extjs/resources/css/ext-all.css',
                                             '/js/feyaSoft/calendar/css/calendar.css' ]

    js_compression :jsmin
    css_compression :simple

  end

  # Application routes
  get '/' do
    haml :index, :layout => :'layouts/application'
  end

  post '/initialLoad' do
    logger.info "Initial logger"
    send_file 'public/fakeData/initLoad.json'
  end

  post '/loadEvent' do
    events = []
    [:jobenfance, :jobdependance].each { |d| events << Societe.using(d).first.events };

    # events += Event.load(params, 'jobdependance')

    # events = Calendar.get_events(params)
    # my_events = events.map { |e| e.to_mycalendar }
    # my_events.sort! { |a,b| Date.parse(a['ymd']) <=> Date.parse(b['ymd']) }
    logger.info("total des events: #{events.flatten.size}")
    # logger.debug(my_events)
    # data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    # haml data.to_json, :layout => false
  end

end

