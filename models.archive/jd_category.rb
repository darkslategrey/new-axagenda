class JdCategory < JdDB
  self.table_name = 'llx_categorie'
  self.inheritance_column = ''

  has_many :category_soc, :class_name => 'JdCatSoc', :foreign_key => 'fk_categorie'
  has_many :societes, :through => :category_soc

  has_many :category_fourn, :class_name => 'JdCatFourn', :foreign_key => 'fk_categorie'
  has_many :fournisseurs, :through => :category_fourn
end
