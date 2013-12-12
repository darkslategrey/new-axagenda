class JeContact < JeDB
  self.table_name = 'llx_socpeople'

  has_many :events, :foreign_key => 'fk_contact', :class_name => 'EventJe', :inverse_of => :contact
  belongs_to :societe, :class_name => 'JeSociete', :foreign_key => 'fk_soc'
end
