class JeCatSoc < JeDB
  self.table_name = 'llx_categorie_societe'

  belongs_to :category, :class_name => 'JeCategory', :foreign_key => 'fk_categorie'
  belongs_to :societe, :class_name => 'JeSociete', :foreign_key => 'fk_societe'
end
