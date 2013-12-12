class UserGroup < Db
  self.table_name = 'llx_usergroup_user'

  belongs_to :users,  :class_name => 'User',  :foreign_key => 'fk_user'
  belongs_to :groups, :class_name => 'Group', :foreign_key => 'fk_usergroup'

end

class Group < Db
  self.table_name = 'llx_usergroup'

  has_many :user_groups, :class_name => 'UserGroup', :foreign_key => 'fk_usergroup'
  has_many :users,       :through    => :user_groups
end

class User < Db
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'Event', :inverse_of => :user_asked
  has_many :events_done,   :foreign_key => 'fk_user_done',   :class_name => 'Event', :inverse_of => :user_done
  has_many :events_todo,   :foreign_key => 'fk_user_action', :class_name => 'Event', :inverse_of => :user_todo

  has_many :user_groups, :class_name => 'UserGroup', :foreign_key => 'fk_user'
  has_many :groups,      :through    => :user_groups


  def has_events?
    self.events_author.size > 0 and return true
    self.events_done.size   > 0 and return true
    self.events_todo.size   > 0 and return true
    return false
  end

end
