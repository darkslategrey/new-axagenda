class EventTypeJe < JeDB
  include EventType

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_c_actioncomm'
  self.primary_key = 'id'

  # to be able to set ids
  attr_accessible :id, :code, :type, :libelle, :module, :active, :todo, :position

  has_many :events, :foreign_key => 'fk_action', :class_name => 'EventJe', :inverse_of => :event_type

  @@logger
end
