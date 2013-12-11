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
    serve '/js', :from => 'public/js'
    serve '/css', :from => 'public/css'

    # js :application, '/js/app.js', [ '/js/extjs/ext-all.js',
    js :application, '/js/axagenda.js', [ '/js/extjs/ext-all.js',
                                          '/js/feyaSoft/calendar/common/CONST_RUBY.js',
                                          '/js/ext_notification.js',
                                          '/js/feyaSoft/calendar/store/DataSource.js',
                                          '/js/feyaSoft/calendar/util/SearchField.js',
                                          '/js/feyaSoft/calendar/util/DatePicker.js',
                                          '/js/feyaSoft/calendar/util/LabelField.js',
                                          '/js/feyaSoft/calendar/multi-language/fr.js',
                                          '/js/feyaSoft/calendar/view/BasicView.js',
                                          '/js/feyaSoft/calendar/control/EventHandler.js',
                                          '/js/feyaSoft/calendar/view/CalendarContainer.js',
                                          '/js/feyaSoft/calendar/view/ResultView.js',
                                          '/js/feyaSoft/calendar/view/Viewer.js',
                                          '/js/feyaSoft/calendar/view/CalendarWin.js',
                                          '/js/feyaSoft/calendar/view/MainPanel.js',
                                          '/js/feyaSoft/calendar/view/MonthView.js',
                                          '/js/feyaSoft/calendar/view/DayView.js',
                                          '/js/feyaSoft/calendar/view/layout/CalendarLayout.js',
                                          '/js/feyaSoft/calendar/view/layout/BlockMap.js',
                                          '/js/feyaSoft/calendar/view/layout/LayoutGrid.js',
                                          '/js/feyaSoft/calendar/view/layout/Line.js',
                                          '/js/feyaSoft/calendar/view/layout/Block.js',
                                          '/js/feyaSoft/calendar/view/popup/SettingPopup.js',
                                          '/js/feyaSoft/calendar/view/popup/ExpirePopup.js',
                                          '/js/feyaSoft/calendar/view/WestPanel.js',
                                          '/js/feyaSoft/calendar/common/BackThread.js',
                                          '/js/feyaSoft/calendar/common/LanManager.js',
                                          '/js/feyaSoft/calendar/common/RepeatType.js',
                                          '/js/feyaSoft/calendar/common/CommentTip.js',
                                          '/js/feyaSoft/calendar/common/Mask.js',
                                          '/js/application.js',
                                          '/js/feyaSoft/calendar/editor/EventEditor.js',
                                          '/js/feyaSoft/calendar/editor/CalendarEditor.js',
                                          '/js/feyaSoft/calendar/editor/DetailEditor.js',
                                          '/js/extjs/ext-all.js' ]

    # css :application, [ '/js/extjs/resources/css/ext-all.css',
    #                     '/css/main.css',
    #                     '/js/feyaSoft/calendar/css/calendar.css' ]
    # serve '/css', :from => 'public'
    # css :application, '/css/app.css', [ '/css/*.css' ]
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

