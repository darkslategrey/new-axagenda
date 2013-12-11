class JdCatFourn < JdDB
  self.table_name = 'llx_categorie_fournisseur'

  belongs_to :category, :class_name => 'JdCategory', :foreign_key => 'fk_categorie'
  belongs_to :fournisseur, :class_name => 'JdSociete', :foreign_key => 'fk_societe'
end
