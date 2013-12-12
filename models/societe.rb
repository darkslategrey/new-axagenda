
class Societe < Db
  self.table_name = 'llx_societe'
  
  has_many :events,   :foreign_key => 'fk_soc', :class_name => 'Event',   :inverse_of => :societe
  has_many :contacts, :foreign_key => 'fk_soc', :class_name => 'Contact', :inverse_of => :societe
  
  has_one :category_soc,     :class_name => 'CatSoc',      :foreign_key => 'fk_societe'
  has_one :category_societe, :through    => :category_soc, :source => 'category'

  has_one :category_fourn,       :class_name => 'CatFourn',      :foreign_key => 'fk_societe'
  has_one :category_fournisseur, :through    => :category_fourn, :source      => 'category'

end
