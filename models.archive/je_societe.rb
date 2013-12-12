
class JeSociete < JeDB
  self.table_name = 'llx_societe'
  
  has_many :events, :foreign_key => 'fk_soc', :class_name => 'EventJe', :inverse_of => :societe
  has_many :contacts, :foreign_key => 'fk_soc', :class_name => 'JeContact', :inverse_of => :societe
  
  has_one :category_soc, :class_name => 'JeCatSoc', :foreign_key => 'fk_societe'
  has_one :category_societe, :through => :category_soc, :source => 'category'

  has_one :category_fourn, :class_name => 'JeCatFourn', :foreign_key => 'fk_societe'
  has_one :category_fournisseur, :through => :category_fourn, :source => 'category'
  # has_one :category_fournisseur

end
