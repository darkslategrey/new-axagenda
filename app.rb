require 'rubygems'
require 'sinatra'
require 'sinatra/assetpack'
require 'haml'
require 'json'
require 'active_record'

$LOAD_PATH.unshift './models'

Dir["models/*.rb"].each { |model| require "./#{model}" }

# Helpers
require './lib/render_partial'

class AxAgenda < Sinatra::Base
  # Set Sinatra variables
  set :root, File.dirname(__FILE__)
  set :app_file, __FILE__

  set :views, 'views'
  set :public_folder, 'public'
  set :haml, {:format => :html5} # default Haml format is :xhtml

  register Sinatra::AssetPack

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
    send_file 'public/fakeData/initLoad.json'
  end

  post '/loadEvent' do
    send_file 'public/fakeData/listEvent.json'
  end

end

