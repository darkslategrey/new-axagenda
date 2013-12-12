class Contact < Db
  self.table_name = 'llx_socpeople'

  has_many   :events,  :foreign_key => 'fk_contact', :class_name   => 'Event', :inverse_of => :contact
  belongs_to :societe, :class_name  => 'Societe',     :foreign_key => 'fk_soc'
end
