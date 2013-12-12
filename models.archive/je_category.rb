require 'je_db'

class JeCategory < JeDB
  self.table_name = 'llx_categorie'
  self.inheritance_column = ''

  has_many :category_soc, :class_name => 'JeCatSoc', :foreign_key => 'fk_categorie'
  has_many :societes, :through => :category_soc

  has_many :category_fourn, :class_name => 'JeCatFourn', :foreign_key => 'fk_categorie'
  has_many :fournisseurs, :through => :category_fourn
end
