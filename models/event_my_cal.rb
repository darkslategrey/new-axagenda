require 'my_cal_db'

class MyCalendarEvent < MyCalDB
  include Event
  # attr_accessor :id # , :doliEventId
  # @cal_id = nil

  self.table_name = 'calendar_event'
  self.primary_key = 'id'
end










