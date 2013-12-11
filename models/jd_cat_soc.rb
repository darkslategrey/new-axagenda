class JdCatSoc < JdDB
  self.table_name = 'llx_categorie_societe'

  belongs_to :category, :class_name => 'JdCategory', :foreign_key => 'fk_categorie'
  belongs_to :societe, :class_name => 'JdSociete', :foreign_key => 'fk_societe'
end
