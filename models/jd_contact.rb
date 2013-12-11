class JdContact < JdDB
  self.table_name = 'llx_socpeople'

  has_many :events, :foreign_key => 'fk_contact', :class_name => 'EventJd', :inverse_of => :contact
  belongs_to :societe, :class_name => 'JdSociete', :foreign_key => 'fk_soc'
end
