class MyCalDB < ActiveRecord::Base
  db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection db_config['mycalendar']
  self.abstract_class = true
end
