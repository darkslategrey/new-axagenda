class CatFourn < Db
  self.table_name = 'llx_categorie_fournisseur'

  belongs_to :category,    :class_name => 'Category', :foreign_key => 'fk_categorie'
  belongs_to :fournisseur, :class_name => 'Societe',  :foreign_key => 'fk_societe'
end
