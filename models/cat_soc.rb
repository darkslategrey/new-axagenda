class CatSoc < Db
  self.table_name = 'llx_categorie_societe'

  belongs_to :category, :class_name => 'Category', :foreign_key => 'fk_categorie'
  belongs_to :societe,  :class_name => 'Societe',  :foreign_key => 'fk_societe'
end
