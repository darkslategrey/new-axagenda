
class EventAlert < CalDB

  def to_s
    "dol_ev_id: #{dol_ev_id} / type_alert: #{type_alert} / " +
      "early: #{early} / unit: #{unit} / emails: #{emails} / text: #{email_text}" 
  end


  
end

