
require 'db'

class Event < Db

  attr_accessor :cal_id

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_actioncomm'
  self.primary_key = 'id'

  # belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventType', :inverse_of => :events

  # fk_user_author / userasked
  # fk_user_done / userdone
  # fk_user_action / usertodo

  belongs_to :user_asked, :foreign_key => 'fk_user_author', :class_name => 'User', :inverse_of => :events_author
  belongs_to :user_done,  :foreign_key => 'fk_user_done',   :class_name => 'User', :inverse_of => :events_done
  belongs_to :user_todo,  :foreign_key => 'fk_user_action', :class_name => 'User', :inverse_of => :events_todo
  
  belongs_to :societe, :foreign_key => 'fk_soc',     :class_name => 'Societe', :inverse_of => :events
  belongs_to :contact, :foreign_key => 'fk_contact', :class_name => 'Contact', :inverse_of => :events


  # def cal_id
  #   event_type.code != 'AC_REGIE' ? Calendar::ACTIONS_JOBENFANCE : Calendar::REGIE_JOBENFANCE
  # end

end


