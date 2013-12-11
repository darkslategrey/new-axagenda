class JeCatFourn < JeDB
  self.table_name = 'llx_categorie_fournisseur'

  belongs_to :category, :class_name => 'JeCategory', :foreign_key => 'fk_categorie'
  belongs_to :fournisseur, :class_name => 'JeSociete', :foreign_key => 'fk_societe'
end
