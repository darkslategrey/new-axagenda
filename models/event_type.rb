
class EventType < Db
  self.inheritance_column = "not_sti"
  self.table_name         = 'llx_c_actioncomm'
  self.primary_key        = 'id'

  # to be able to set ids
  attr_accessible :id, :code, :type, :libelle, :module, :active, :todo, :position

  has_many :events, :foreign_key => 'fk_action', :class_name => 'Event', :inverse_of => :event_type

  def self.valid(doli_db)
    valid_types = EventType.using(doli_db).where("code not in (?)", %w(AC_OTH_AUTO AC_REGIE AC_COM))
    @@logger.debug "#{valid_types.size} valid_types found"
    valid_types
  end

end
