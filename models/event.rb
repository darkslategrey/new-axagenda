
require 'db'

class Event < Db

  attr_accessor :cal_id

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_actioncomm'
  self.primary_key = 'id'

  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventType', :inverse_of => :events

  # fk_user_author / userasked
  # fk_user_done / userdone
  # fk_user_action / usertodo

  belongs_to :user_asked, :foreign_key => 'fk_user_author', :class_name => 'User', :inverse_of => :events_author
  belongs_to :user_done,  :foreign_key => 'fk_user_done',   :class_name => 'User', :inverse_of => :events_done
  belongs_to :user_todo,  :foreign_key => 'fk_user_action', :class_name => 'User', :inverse_of => :events_todo
  
  belongs_to :societe, :foreign_key => 'fk_soc',     :class_name => 'Societe', :inverse_of => :events
  belongs_to :contact, :foreign_key => 'fk_contact', :class_name => 'Contact', :inverse_of => :events



  def to_axagenda
    self_json = self.to_json

    alerts  = EventAlert.where("dol_ev_id = #{self.id} and event_class_name = '#{self.class.name}'")
    uploads = Upload.where("ev_id = #{self.id} and classname = '#{self.class.name}'")
    repeat  = Repeat.where("ev_id = #{self.id} and classname = '#{self.class.name}'").first
    

    if(not repeat.nil?)
      repeat_h = JSON.parse(repeat.to_json)['repeat']
      if not repeat.rday.nil? 
        repeat_h['rday'] = JSON.parse(repeat.rday) 
      else
        repeat_h.delete('rday')
      end
      repeat_h['endDay'] = 'no' if repeat_h['endDay'].nil?
      repeat = repeat_h
    else
      repeat = 'no'
    end

    alertFlag = []
    alerts.each { |af|
      alert = {}
      alert['type'] = af.type_alert
      alert['early'] = af.early
      alert['unit'] = af.unit
      alert['emails'] = af.emails
      alert['id_alert_flag'] = af.id
      alert['text'] = af.email_text
      alertFlag.push(alert)
    }
    
    uploadedFiles = []
    uploads.each { |u| uploadedFiles.push(u.filepath) }
    
    # self.logger.info("uploadedFiles <#{uploadedFiles}>")

    endTime   = Utils.end_hour(self) + ':' + Utils.end_minute(self)
    startTime = Utils.start_hour(self) + ':' + Utils.start_minute(self)
    # self.logger.info("StartTime : <"+startTime+"> endTime <"+endTime+">")
    my_json = { "calendarId" => self.cal_id,
      "subject"     =>  self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "repeatType"  =>  repeat.to_json,
      "class"       =>  "CalendarEventUIModel",
      "endTime"     =>  endTime,
      "fulldayevent"=>  self.fulldayevent,
      "finished"    =>  self.percent == 100 ? "true" : "false",
      "id"          =>  id,
      "startTime"   =>  startTime, 
      "alertFlag"   =>  alertFlag.size == 0 ? false : alertFlag.to_json,
      "color"       =>  Calendar.find(cal_id).color,
      "ymd"         =>  Utils.start_date(self).to_s,
      "description" =>  self.note.nil? ? '' : self.note.gsub(/\n/, ' '),
      "uploads"     => uploadedFiles.size == 0 ? false : uploadedFiles,
      "eymd"        => Utils.end_date(self).to_s,
      "societe"     => Utils.societe_url(self.societe),
      "contact"     => Utils.contact_url(self.contact),
      "tel"         => Utils.contact_tel(self.contact),
      "email"       => Utils.contact_email(self.contact),
      "userasked"   => self.user_asked.nil? ? '' : self.user_asked.rowid, # fk_user_author
      "userdone"    => self.user_done.nil? ? '' : self.user_done.rowid,
      "usertodo"    => self.user_todo.nil? ? '' : self.user_todo.rowid, # fk_user_action
      "locked"      =>  false }
    my_json
  end
  
  # def cal_id
  #   event_type.code != 'AC_REGIE' ? Calendar::ACTIONS_JOBENFANCE : Calendar::REGIE_JOBENFANCE
  # end

end


