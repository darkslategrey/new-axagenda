class AddDoliInfoColumnsToAxCalendarEventTable < ActiveRecord::Migration
  using(:axagenda)

  def self.up
    add_column :calendar_event, :dol_id, :integer
    add_column :calendar_event, :dol_name, :string
    add_column :calendar_event, :event_dol_id, :integer
  end

  def self.down
    remove_column :calendar_event, :event_dol_id
    remove_column :calendar_event, :dol_name
    remove_column :calendar_event, :dol_id
  end

end
