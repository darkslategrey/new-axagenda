# -*- coding: utf-8 -*-
module Event 

  # "{\"rtype\":\"day\",\"intervalSlot\":5,\"dspan\":0,\"beginDay\":\"2013-03-26\",\"endDay\":\"2014-04-16\"}"
  # "{\"rtype\":\"week\",\"intervalSlot\":1,\"dspan\":0,\"beginDay\":\"2013-03-27\",\"endDay\":\"no\",\"rday\":{\"2\":true,\"3\":true,\"4\":true}}"
  # "{\"rtype\":\"week\",\"intervalSlot\":3,\"dspan\":0,\"beginDay\":\"2013-03-26\",\"endDay\":\"no\",\"rtime\":10,\"rday\":{\"1\":true,\"2\":true,\"3\":true}}"
  def setRepeat(repeatType)
    
    if repeatType == 'no'
      self.logger.info("No repeat")
      return
    end
    repeat_data = JSON.parse(repeatType)
    repeat_data['rday'] = JSON.unparse(repeat_data['rday']) unless repeat_data['rday'].nil?
    self.logger.info("RDAY #{repeat_data['rday']}")
    conditions = "ev_id = #{self.id} and classname = '#{self.class.name}'"
    repeat_data['ev_id'] = self.id
    repeat_data['classname'] = self.class.name
    self.logger.info("setRepeat conditions <"+conditions+">")
    repeat = Repeat.where(conditions).first
    if not repeat.nil?
      repeat.update_attributes(repeat_data) 
    else
      repeat = Repeat.new(repeat_data)
    end
    repeat.save
  end

  def to_mobile_device
    endTime   = Utils.end_hour(self) + ':' + Utils.end_minute(self)
    startTime = Utils.start_hour(self) + ':' + Utils.start_minute(self)

    calendar_color = ''

    case self.class.name
    when 'EventJe'
      if self.event_type.code == 'AC_REGIE'
        calendar_color = Calendar.find(Calendar::REGIE_JOBENFANCE).color
      else
        calendar_color = Calendar.find(Calendar::ACTIONS_JOBENFANCE).color
      end
    when 'EventJd'
      if self.event_type.code == 'AC_REGIE'
        calendar_color = Calendar.find(Calendar::REGIE_JOBDEPENDANCE).color
      else
        calendar_color = Calendar.find(Calendar::ACTIONS_JOBDEPENDANCE).color
      end
    end

    mobile_data = {
      "event" => "#{startTime} - #{endTime}",
      "title" => self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "start" => self.datep,
      "end"   => self.datep2.nil? ? self.datep : self.datep2,
      "css"   => calendar_color
    }
    mobile_data
  end


  def to_mycalendar_db(cal_id=1)
    my_calendar_event = MyCalendarEvent.where(:doliEventId => self.id).first
    if not my_calendar_event.nil?
      return my_calendar_event
    end
    my_calendar_event = MyCalendarEvent.new
    my_ce             = my_calendar_event

    my_ce.doliEventId = self.id
    my_ce.userId      = self.user_todo.nil? ? 1 : self.user_todo.rowid
    my_ce.calendarId  = self.cal_id
    my_ce.repeatType  = 'no'
    my_ce.creation_date = DateTime.now
    my_ce.description = self.note.nil? ? '' : self.note
    my_ce.subject     = self.label.nil? ? '' : self.label + " " + self.id.to_s
    # my_ce.description = self.note.nil? ? '' : self.note.encode('utf-8'),
    # my_ce.subject     = self.label.nil? ? '' : self.label.encode('utf-8'),
    my_ce.update_date = DateTime.now
    my_ce.locked      = 0
    
    # toute la journée
    hour_start = self.datep.to_s.split[1]
    hour_end   = self.datep2.nil? ? nil : self.datep2.to_s.split[1]

    date_start = self.datep.to_s.split[0]
    date_end   = self.datep2.nil? ? nil : self.datep2.to_s.split[0]


    
    if self.datep2.nil? or (date_start == date_end and hour_start == hour_end) or (date_start == date_end and hour_start == '00:00:00' and hour_end == '23:59:00') 
      my_ce.startTime = "#{self.datep.to_s.split[0]} 00:00"
      my_ce.endTime   = "#{self.datep.to_s.split[0]} 24:00"
    else
      my_ce.startTime   = self.datep
      my_ce.endTime     = self.datep2 || self.datep || DateTime.now
    end

    my_ce
  end

  def to_mycalendar(cal_id=1)
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

  def to_doli(json)
    json_obj = JSON.parse(json.to_json)

    self.logger.info("json obj <"+ json_obj.to_s + ">")

    datep = json_obj['startDay'].nil? ? json_obj['ymd'] : json_obj['startDay']
    datep += ' '
    datep2 = json_obj['endDay'].nil? ? json_obj['eymd'] : json_obj['endDay']
    datep2 += ' '

    if json_obj['fulldayevent'] == 1
      datep += '00:00:00'
      datep2 += '23:59:00'
      fulldayevent = 1
    else
      datep += json_obj['startHMTime'].nil? ? json_obj['startTime'] : json_obj['startHMTime']
      datep2 += json_obj['endHMTime'].nil? ? json_obj['endTime'] : json_obj['endHMTime']
      fulldayevent = 0
    end

    percent = json_obj['finished'] == "true" ? 100 : 0
    # json_obj['startDay'] == json_obj['endDay'] and json_obj['startHMTime'] == '00:00' and json_obj['endHHTime'] == '24:00' and fulldayevent = 1

    self.logger.info("to_doli <" + json_obj.to_s + ">")
    fk_action = nil

    case json_obj['calendarId'].to_i
    when Calendar::REGIE_JOBENFANCE
      fk_action = EventTypeJe.where('code = "AC_REGIE"').first.id
    when Calendar::REGIE_JOBDEPENDANCE
      fk_action = EventTypeJd.where('code = "AC_REGIE"').first.id
    when Calendar::ACTIONS_JOBENFANCE
      fk_action = EventTypeJe.where('code = "AC_OTH"').first.id
    when Calendar::ACTIONS_JOBDEPENDANCE
      fk_action = EventTypeJd.where('code = "AC_OTH"').first.id
    else
      self.logger.error("Calendrier inconnu : <#{json_obj['calendarId']}>")
      e = Exception.new("Calendrier inconnu : <#{json_obj['calendarId']}>")
      raise e
    end

    doli_json = {
      "datec" =>  "#{datec}", # "2010-06-03T10:37:42+02:00",
      "datep" =>  "#{datep}", # 2010-06-03T10:37:42+02:00",
      "datep2" =>  "#{datep2}",# 2010-06-03T10:37:42+02:00",
      "fulldayevent" => fulldayevent,
      "entity" =>  1,
      "fk_action" => fk_action,
      "fk_user_action" =>  json_obj['usertodo'].nil? ? '' : json_obj['usertodo'].split('#')[0],
      "fk_user_author" =>  json_obj['userId'] || 1,
      "fk_user_done" =>  json_obj['userdone'].nil? ? '' : json_obj['userdone'].split('#')[0],
      "label" =>  json_obj['subject'], # "Societe PEOPLE AND BABY ajoutee dans Dolibarr",
      "location" =>  "", 
      "note" =>  json_obj['description'], 
      "priority" =>  0,
      "punctual" =>  1,
      "ref_ext" =>  nil,
      "percent" => percent,
      "tms" =>  Date.current 
    }

    self.logger.info("apres conversion <"+ doli_json.to_s + ">")
    doli_json
  end

end

