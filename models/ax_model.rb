

class AxDb < ActiveRecord::Base

  db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  ActiveRecord::Base.establish_connection db_config['axagenda']

  self.abstract_class = true
end

class AxEvent < AxDb
  self.table_name = 'calendar_event'

  belongs_to :ax_reminder, :class_name => 'AxReminder'
  has_one :ax_user, :class_name => 'AxUser'

end


class AxReminder < AxDb
  self.table_name = 'calendar_event_reminder'
  self.inheritance_column = ''

  has_many :ax_events, :class_name => 'AxEvent'
end


class AxSetting < AxDb
  self.table_name  = 'calendar_setting'
  self.primary_key = 'userId' # ???
end


class AxType < AxDb
  self.table_name  = 'calendar_type'
  self.primary_key = 'userId' # ???

  has_one :ax_user, :class_name => 'AxUser'

  def is_hidden?(name)
    Agenda.where(:name => name).first.hide
  end
end

class AxUser < AxDb
  self.table_name = 'user'

  belongs_to :ax_type, :class_name => 'AxType', :foreign_key => 'userId'
  belongs_to :ax_event, :class_name => 'AxEvent', :foreign_key => 'userId'
  belongs_to :ax_setting, :class_name => 'AxSetting', :foreign_key => 'userId'
end


