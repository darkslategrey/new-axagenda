class JdUserGroup < JdDB
  self.table_name = 'llx_usergroup_user'

  belongs_to :users, :class_name => 'JdUser', :foreign_key => 'fk_user'
  belongs_to :groups, :class_name => 'JdGroup', :foreign_key => 'fk_usergroup'

end

class JdGroup < JdDB
  self.table_name = 'llx_usergroup'

  has_many :user_groups, :class_name => 'JdUserGroup', :foreign_key => 'fk_usergroup'
  has_many :users, :through => :user_groups
end

class JdUser < JdDB
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'EventJd', :inverse_of => :user_asked
  has_many :events_done, :foreign_key => 'fk_user_done', :class_name => 'EventJd', :inverse_of => :user_done
  has_many :events_todo, :foreign_key => 'fk_user_action', :class_name => 'EventJd', :inverse_of => :user_todo

  has_many :user_groups, :class_name => 'JdUserGroup', :foreign_key => 'fk_user'
  has_many :groups, :through => :user_groups

  def has_events?
    self.events_author.size > 0 and return true
    self.events_done.size > 0 and return true
    self.events_todo.size > 0 and return true
    return false
  end

end
